require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test "create" do
    assert a = Account.create( :username => "foobar", :password => "foobar", :password_confirmation => "foobar" )
    assert a.valid?
  end

  test "password hashing" do
    assert Account.create( :username => "foobar", :password => "foobar", :password_confirmation => "foobar" )
    # Force a full reload
    assert a = Account.last
    assert a.crypted_password.present?
    assert a.password_salt.present?
    assert_not_equal "foobar", a.password
    assert_not_equal "foobar", a.crypted_password
  end

  test "fail with password mismatch" do
    assert a = Account.new( :username => "foobar", :password => "foobar", :password_confirmation => "barbaz" )
    assert a.invalid?
  end
end
