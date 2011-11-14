require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  test "validates random token default size" do
    token = Account.create_random_token
    assert_equal 8, token.size
  end

  test "new account creation" do
    username = 'bob'
    email = 'bob@blop.blop'
    ta = TentativeAccount.create( :username => username, :user_type => 'student', :email => email, :confirmation_token => 'ABCD' )
    password = Account.create_from_tentative ta
    assert_not_nil password

    # an account should have been created
    account = Account.find_by_username username
    assert_equal email, account.email
    
    # a plan should have been created
    plan = Plan.find_by_user_id account.userid
    assert_equal '', plan.plan

    # tentative account should have been deleted
    ta = TentativeAccount.find_by_username username
    assert_equal nil, ta
  end

    
end

# == Schema Information
#
# Table name: accounts
#
#  userid            :integer         not null, primary key
#  username          :string(16)      default(""), not null
#  created           :datetime
#  password          :string(34)
#  email             :string(64)
#  pseudo            :string(64)
#  login             :datetime
#  changed           :datetime
#  poll              :integer(1)
#  group_bit         :string(1)
#  spec_message      :string(255)
#  grad_year         :string(4)
#  edit_cols         :integer(1)
#  edit_rows         :integer(1)
#  webview           :string(1)       default("0")
#  notes_asc         :string(1)
#  user_type         :string(128)
#  show_images       :boolean         default(FALSE), not null
#  guest_password    :string(30)
#  is_admin          :boolean         default(FALSE)
#  persistence_token :string(255)
#  password_salt     :string(255)
#

