require 'test_helper'

class AccountSessionsControllerTest < ActionController::TestCase
  test "new" do
    get :new
    assert_template :new
  end

  test "login" do
    assert Account.create!( :username => "foobar", :password => "foobar", :password_confirmation => "foobar" )
    post :create, :account_session => { :username => "foobar", :password => "foobar" }
    assert_response :redirect
  end

  test "bad login" do
    assert Account.create( :username => "foobar", :password => "foobar", :password_confirmation => "foobar" )
    post :create, :account_session => { :username => "foobar", :password => "barbaz" }
    assert_response :success
    assert_template :new
  end
end
