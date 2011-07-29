class Secret < ActiveRecord::Base
  set_primary_key :secret_id
  validates_presence_of :secret_text
  validates_inclusion_of :display, :in => %w( yes no )
  attr_protected :display, :date_approved
  before_create :set_defaults
  
  private
  
  def set_defaults
    self.date = Time.now
    self.display = "no"
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

