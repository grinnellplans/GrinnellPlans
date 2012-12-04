class Interface < ActiveRecord::Base
  set_table_name "interface" 
  set_primary_key :interface
  validates_presence_of :path
  has_many :displays, :foreign_key =>:interface
end


# == Schema Information
#
# Table name: interface
#
#  interface :integer         not null, primary key
#  path      :string(128)
#  descr     :string(255)
#

