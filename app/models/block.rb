class Block < ActiveRecord::Base
  belongs_to :blocked_user, class_name: "Account"
  belongs_to :blocking_user, class_name: "Account"
end
