class Permission < ActiveRecord::Base
  set_table_name "perms"
  belongs_to :account, :foreign_key=> :userid
end


# == Schema Information
#
# Table name: perms
#
#  userid :integer         not null
#  status :string(32)
#

