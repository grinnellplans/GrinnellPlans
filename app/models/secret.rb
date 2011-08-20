class Secret < ActiveRecord::Base
  set_primary_key :secret_id
  self.per_page = 5
 
  DISPLAY_OPTIONS = ["yes", "no"]
  validates_presence_of :secret_text
  validates_inclusion_of :display, :in =>DISPLAY_OPTIONS
  validates_length_of :secret_text, :maximum => 16777215
  attr_protected :display, :date_approved
  before_create do 
    self.set_date = Time.now
  end
  before_update do
     self.date_approved = Time.now
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

