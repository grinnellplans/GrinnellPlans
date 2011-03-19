require 'test_helper'

class PlansControllerTest < ActionController::TestCase
  def setup
    assert @account = Account.create( :username => "testaccount" )
    assert @plan = Plan.create( :account => @account, :edit_text => "" )
  end

  test "redirects to login when no user present" do
    get :show, { :id => @account.username }, { }
    assert_redirected_to new_account_session_path
  end
end
