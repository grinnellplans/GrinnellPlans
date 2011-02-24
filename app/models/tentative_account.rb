class TentativeAccount < ActiveRecord::Base
  set_primary_key :tentative_accounts_id
end


# == Schema Information
#
# Table name: tentative_accounts
#
#  tentative_accounts_id :integer(4)      not null, primary key
#  created               :datetime
#  token                 :string(16)
#  session               :string(200)
#

