class SubBoard < ActiveRecord::Base
  self.table_name = 'subboard'
  self.primary_key = :messageid
  belongs_to :main_board, :foreign_key => :threadid
  belongs_to :account, foreign_key: :userid

  validates_presence_of :threadid, :userid, :contents
end
