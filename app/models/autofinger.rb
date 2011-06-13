class Autofinger < ActiveRecord::Base
  set_table_name :autofinger
  validates_presence_of :owner, :interest, :priority
  
  belongs_to :interested_party, :foreign_key => :owner, :class_name => "Account"
  belongs_to :subject_of_interest, :foreign_key => :interest, :class_name => "Account"
  validates_presence_of :interest, :owner
  
  def self.mark_as_read(owner, interest)
     autofinger = Autofinger.where(:owner=>owner, :interest=> interest ).first
      unless autofinger.blank?
        autofinger.updated = '0'
        autofinger.readtime = Time.now
        # autofinger.save
        #TODO fix error
      end
  end
end

# == Schema Information
#
# Table name: autofinger
#
#  owner    :integer(2)      default(0), not null
#  interest :integer(2)      default(0), not null
#  priority :integer(1)
#  updated  :string(1)
#  updtime  :datetime
#  readtime :datetime
#

