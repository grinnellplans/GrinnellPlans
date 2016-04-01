class Block < ActiveRecord::Base
  belongs_to :blocked_user, class_name: "Account", foreign_key: :blocked_userid
  belongs_to :blocking_user, class_name: "Account", foreign_key: :blocking_userid
end
