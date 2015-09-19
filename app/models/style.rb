class Style < ActiveRecord::Base
  self.table_name = 'style'
  validates_presence_of :path
  has_many :displays, foreign_key: :style
end
