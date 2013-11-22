class Permission < ActiveRecord::Base
  self.table_name = 'perms'
  belongs_to :account, foreign_key: :userid
end

# == Schema Information
#
# Table name: perms
#
#  userid :integer         not null, primary key
#  status :string(32)
#
