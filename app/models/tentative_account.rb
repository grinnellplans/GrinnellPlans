class TentativeAccount < ActiveRecord::Base
end







# == Schema Information
#
# Table name: tentative_accounts
#
#  id                 :integer         not null, primary key
#  username           :string(255)
#  email              :string(255)
#  user_type          :string(255)
#  confirmation_token :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

