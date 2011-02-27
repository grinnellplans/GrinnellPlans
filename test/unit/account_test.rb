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
    assert ! a.valid_password?( "barbaz" )
    assert a.valid_password?( "foobar" )
  end

  test "fail with password mismatch" do
    assert a = Account.new( :username => "foobar", :password => "foobar", :password_confirmation => "barbaz" )
    assert a.invalid?
  end

  test "matches legacy MD5 password" do
    assert a = Account.create( :username => "foobar", :crypted_password => "$1$f8Qwor9I$bSkUziPv/xNI/.Vhb/NUr." )
    assert ! a.valid_password?( "barbaz" )
    assert a.valid_password?( "foobar" )
  end

  test "matches legacy DES password" do
    assert a = Account.create( :username => "foobar", :crypted_password => "abVbJXzHUY99s" )
    assert ! a.valid_password?( "barbaz" )
    assert a.valid_password?( "foobar" )
  end

  test "transitions legacy MD5 password" do
    old_crypted = "$1$f8Qwor9I$bSkUziPv/xNI/.Vhb/NUr."
    assert a = Account.create( :username => "foobar", :crypted_password => old_crypted )
    a.valid_password?( "barbaz" )
    assert_equal old_crypted, a.crypted_password
    a.valid_password?( "foobar" )
    assert_not_equal old_crypted, a.crypted_password
  end

  test "transitions legacy DES password" do
    old_crypted = "abVbJXzHUY99s"
    assert a = Account.create( :username => "foobar", :crypted_password => old_crypted )
    a.valid_password?( "barbaz" )
    assert_equal old_crypted, a.crypted_password
    a.valid_password?( "foobar" )
    assert_not_equal old_crypted, a.crypted_password
  end
end
