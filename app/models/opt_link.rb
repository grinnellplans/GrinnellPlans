class OptLink < ActiveRecord::Base
  belongs_to :account, foreign_key: :userid
  belongs_to :avail_link, foreign_key: :linknum
  validates_presence_of :account, :avail_link
end
