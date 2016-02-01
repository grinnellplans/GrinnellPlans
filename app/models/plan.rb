class Plan < ActiveRecord::Base
  include PlanTextFormatting

  belongs_to :account, foreign_key: :user_id
  before_save :clean_text
  after_update :set_modified_time
  after_update :update_autofingers
  alias_attribute :generated_html, :plan
  # validates_presence_of :account
  validates_length_of :plan, maximum: 16_777_215, message: 'Your plan is too long'
  validates_length_of :edit_text, maximum: 16_777_215, message: 'Your plan is too long'

  # TODO: Consider migrating user_id to userid, like everythig else
  def userid
    user_id
  end

  def generated_html
    read_attribute(:plan).html_safe
  end

  def clean_text
    self.generated_html = clean_and_format edit_text
  end

  private

  def set_modified_time
    account.changed = Time.now
    account.save!
  end

  def update_autofingers
    account.interests_from_others.update_all(updated: 1)
  end
end
