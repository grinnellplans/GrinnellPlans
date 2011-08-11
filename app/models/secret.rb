class Secret < ActiveRecord::Base
  set_primary_key :secret_id
  self.per_page = 100
 
  DISPLAY_OPTIONS=["yes", "no", nil]
  validates_presence_of :secret_text
  validates_inclusion_of :display, :in =>DISPLAY_OPTIONS
  validates_length_of :secret_text, :maximum => 16777215
  attr_protected :display, :date_approved
  before_create :set_date
  
  private
  
  def set_date
    self.date = Time.now
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

