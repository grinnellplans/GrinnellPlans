class Account < ActiveRecord::Base
  include Links

  self.primary_key = :userid
  validates :username, presence: true, length: { maximum: 16 }
  validates :password, length: { maximum: 34 }
  validates :email, length:  { maximum: 64 }
  validates :guest_password, length: { maximum: 64 }
  validates :show_images, presence: true
  validates :user_type, length:  { maximum: 128 }

  # validate :grad_year_for_user_type

  has_many :interests_in_others, class_name: 'Autofinger', foreign_key: 'owner', dependent: :destroy
  has_many :people_that_interest_me, class_name: 'Account', through: :interests_in_others, source: 'subject_of_interest', dependent: :destroy
  has_many :interests_from_others, -> { unblocked }, class_name: 'Autofinger', foreign_key: 'interest', dependent: :destroy
  has_many :board_votes, foreign_key: :userid, dependent: :destroy
  has_many :opt_links, foreign_key: :userid, dependent: :destroy
  has_many :avail_links, through: :opt_links
  has_one :permission, foreign_key: :userid, dependent: :destroy
  has_many :poll_votes, foreign_key: :userid, dependent: :destroy
  has_many :main_boards, foreign_key: :userid
  has_many :sub_boards, foreign_key: :userid
  has_one :viewed_secret, foreign_key: :userid, dependent: :destroy
  has_one :plan, foreign_key: :user_id, dependent: :destroy
  has_many :target_blocks, class_name: "Block", foreign_key: :blocked_user_id
  has_many :source_blocks, class_name: "Block", foreign_key: :blocking_user_id
  has_many :blocked_users, through: :source_blocks, source: :blocked_user

  has_one :display_preference, foreign_key: :userid, dependent: :destroy
  has_one :custom_stylesheet, foreign_key: :userid, dependent: :destroy
  has_one :style, through: :display_preference

  before_validation do
    self.show_images = true
  end

  before_create do
    self.created = Time.now
    self.is_admin = false
    self.edit_cols = 70
    self.edit_rows = 14
  end

  #   after_create do
  #     self.plan.create
  #     # TODO create links for new user
  #   end

  # can't have "changed" attribute because of changed? method
  class << self
    def instance_method_already_implemented?(method_name)
      return true if method_name == 'changed?' || method_name == 'changed'
      super
    end
  end

  def changed_date=(value)
    self[:changed] = value
  end

  def changed_date
    self[:changed]
  end

  def created_date=(value)
    self[:created] = value
  end

  def created_date
    self[:created]
  end

  # def grad_year_for_user_type
  #    (user_type == 'student' && grad_year > 0) || user_type != 'student'
  #  end
  #

  acts_as_authentic do |c|
    c.login_field :username
    c.crypted_password_field :crypted_password
    c.crypto_provider PhpCrypt::CryptoProviders::MD5
    c.transition_from_crypto_providers PhpCrypt::CryptoProviders::DES
    c.validate_email_field false
    c.check_passwords_against_database false
    c.perishable_token_valid_for 1.day.to_i # NOTE, the password reset email says it expires in 24 hours.
  end

  # Trick authlogic into behaving with our column name
  def crypted_password=(hash)
    write_attribute :password, hash
  end

  def crypted_password
    read_attribute :password
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.password_reset_instructions(self).deliver_later
  end

  def self.create_from_tentative(tentative_account, temp_password)
    ta = tentative_account
    a = nil
    account_created = ActiveRecord::Base.transaction do
      a = Account.create(username: ta.username,
                         email: ta.email,
                         user_type: ta.user_type,
                         password: temp_password,
                         password_confirmation: temp_password,
                         created: Time.now)
      Plan.create(user_id: a.userid,
                  plan: '',
                  edit_text: '')
      ta.delete
    end

    return a if account_created
    nil
  end

  def self.create_random_token(length = 8)
    characters = ('A'..'Z').to_a + (0..9).to_a
    characters -= ['B'] # B and 8 look very similar
    characters -= ['O'] # O and 0 look very similar
    characters.sort_by { rand }
    (1..length).map { characters.sample }.join
  end

  def forem_name
    "[#{username}]"
  end

  def forem_admin?
    is_admin?
  end
end
