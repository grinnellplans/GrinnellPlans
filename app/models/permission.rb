class Permission < ActiveRecord::Base
  set_table_name "perms"
  belongs_to :account, :foreign_key=> :userid
end

# == Schema Information
#
# Table name: perms
#
#  userid :integer(2)      not null
#  status :string(32)
#

