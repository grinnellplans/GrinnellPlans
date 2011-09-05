class TentativeAccount < ActiveRecord::Base
  set_primary_key :tentative_accounts_id
end





# == Schema Information
#
# Table name: tentative_accounts
#
#  id                 :integer         not null
#  username           :string(255)
#  email              :string(255)
#  user_type          :string(255)
#  confirmation_token :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

