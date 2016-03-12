class Block < ActiveRecord::Base
  belongs_to :account, foreign_key: :blocked_userid
  belongs_to :account, foreign_key: :blocking_userid
end
