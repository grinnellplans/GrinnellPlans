class Display < ActiveRecord::Base
  set_table_name "display"
  set_primary_key :userid
  belongs_to :inerface, :foreign_key =>:interface
  belongs_to :account, :foreign_key=> :userid
  belongs_to :style, :foreign_key=>:style
end
# == Schema Information
#
# Table name: display
#
#  userid    :integer(2)      default(0), not null, primary key
#  interface :integer(1)
#  style     :integer(1)
#

