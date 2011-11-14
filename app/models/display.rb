class Display < ActiveRecord::Base
  set_table_name "display"
  set_primary_key :userid
  belongs_to :interface, :foreign_key =>:interface
  belongs_to :account, :foreign_key=> :userid
  belongs_to :style, :foreign_key=>:style
end

# == Schema Information
#
# Table name: display
#
#  userid    :integer         not null, primary key
#  interface :integer(1)
#  style     :integer(1)
#

