class Display < ActiveRecord::Base
  self.table_name = 'display'
  self.primary_key = :userid
  belongs_to :interface, foreign_key: :interface
  belongs_to :account, foreign_key: :userid
  belongs_to :style, foreign_key: :style
end
