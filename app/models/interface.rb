class Interface < ActiveRecord::Base
  self.table_name = 'interface'
  self.primary_key = :interface
  validates_presence_of :path
  has_many :displays, foreign_key: :interface
end
