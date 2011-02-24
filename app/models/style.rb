class Style < ActiveRecord::Base
  set_table_name "style"
  has_many :displays, :foreign_key => :style
end

# == Schema Information
#
# Table name: style
#
#  style :integer(1)      not null
#  path  :string(128)
#  descr :string(255)
#

