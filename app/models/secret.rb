class Secret < ActiveRecord::Base
  self.primary_key = :secret_id
  paginates_per 100

  DISPLAY_OPTIONS = %w{yes no}
  validates :secret_text, presence: true
  validates :display_attr, inclusion: { in:  DISPLAY_OPTIONS }
  validates :secret_text, length: { maximum: 16_777_215 }

  before_validation on: :create do
    self.display_attr = 'no' if display_attr.blank?
  end

  before_create do
    self.date = Time.now
  end

  before_update do
    #in old plans date_approved was populated when display='no' too
    self.date_approved = Time.now
  end

  # can't have "display" attribute because of Object.display ruby method
  # the "display" method has to do with why string.to_s is displayed in the tests
  class << self
    def instance_method_already_implemented?(method_name)
      return true if method_name == 'display'
      super
    end
  end

  def display_attr=(value)
    self[:display] = value
  end

  def display_attr
    self[:display]
  end

end
