class Secret < ActiveRecord::Base
  self.primary_key = :secret_id
  self.per_page = 5

  DISPLAY_OPTIONS = %w{yes no}
  validates_presence_of :secret_text
  validates_inclusion_of :display_attr, in:  DISPLAY_OPTIONS
  validates_length_of :secret_text, maximum: 16_777_215
  attr_protected :display_attr, :date_approved

  before_validation on: :create do
    self.display_attr = 'no' if display_attr.blank?
  end

  before_create do
    self.date = Time.now
  end

  before_update do
    self.date_approved = Time.now
  end

  # can't have "display" attribute because of Object.display ruby method
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

# == Schema Information
#
# Table name: secrets
#
#  secret_id     :integer         not null, primary key
#  secret_text   :text
#  date          :datetime
#  display       :string(5)
#  date_approved :datetime
#
