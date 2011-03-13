class MainBoard < ActiveRecord::Base
  set_table_name "mainboard"
  set_primary_key "threadid" 
  belongs_to :account, :foreign_key=> :userid
  has_many :sub_boards, :foreign_key =>:threadid
end


# == Schema Information
#
# Table name: mainboard
#
#  threadid    :integer         not null, primary key
#  title       :string(128)
#  created     :datetime
#  lastupdated :datetime
#  userid      :integer(2)      default(0), not null
#

