class Style < ActiveRecord::Base
  set_table_name "style"
  validates_presence_of :path
  has_many :displays, :foreign_key => :style
end


# == Schema Information
#
# Table name: style
#
#  style :integer         not null
#  path  :string(128)
#  descr :string(255)
#

