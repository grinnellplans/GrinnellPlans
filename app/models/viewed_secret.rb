class ViewedSecret < ActiveRecord::Base
  self.primary_key = :userid
  belongs_to :account, foreign_key: :userid
end
