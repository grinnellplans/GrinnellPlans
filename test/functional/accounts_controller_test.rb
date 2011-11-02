require 'test_helper'

class AccountsControllerTest < ActionController::TestCase

  test "should get registration page" do
    get :new
    assert_response :success
  end

  test "should create tentative account" do
    
    ta = TentativeAccount.find_by_username "plans"
    assert_nil ta

    post :create, { :account => { 
        "username" => "plans", 
        "email_domain" => "grinnell.edu",
        "user_type" => "student"}}
    
    ta = TentativeAccount.find_by_username "plans"
    assert_equal "plans", ta.username
  end

  test "valid tentative account already exists" do
    ta = TentativeAccount.create( :username => 'plans',
                                  :user_type => 'student',
                                  :email => 'plans@plans.plans',
                                  :confirmation_token => 'PLAN9' )
    post :create, { :account => { :username => ta.username }}
    assert_select 'p', /A confirmation email has already been sent to #{ta.email}/
  end
  
  test "account already exists" do
  end
  
  test "expired tentative is cleared on create" do
  end

  test "confirmation email is sent on create" do
  end

  test "confirm account successfully" do
    ta = TentativeAccount.create( :username => 'plans',
                                  :user_type => 'student',
                                  :email => 'plans@plans.plans',
                                  :confirmation_token => 'PLAN9' )

    account = Account.find_by_username ta.username
    assert_nil account

    get :confirm, { :token => 'PLAN9' }
    assert_select 'p', /Thank you for confirming your email/

    account = Account.find_by_username 'plans'
    assert_not_nil account
    assert_equal ta.email, account.email
  end

  test "confirm welcome email" do
  end

  test "confirm with expired tentative account" do
  end

  test "confirm with wrong token" do
  end
  
  test "resend confirmation email" do
  end

end
