class Stylesheet < ActiveRecord::Base
  self.table_name = 'stylesheet'
  belongs_to :account, foreign_key: :userid

end
