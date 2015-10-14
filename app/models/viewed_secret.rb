class ViewedSecret < ActiveRecord::Base
  self.primary_key = :userid
  validates_presence_of :account
  belongs_to :account, foreign_key: :userid
end
