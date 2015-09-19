class Permission < ActiveRecord::Base
  self.table_name = 'perms'
  belongs_to :account, foreign_key: :userid
end
