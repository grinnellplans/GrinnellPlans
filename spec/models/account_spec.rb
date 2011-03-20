require 'spec_helper'

shared_examples_for "password oracle" do
  it "validates correct password" do
    subject.valid_password?( "foobar" ).should be_true
  end
  it "does not validate incorrect password" do
    subject.valid_password?( "barbaz" ).should be_false
  end
end

describe Account do
  context "with password" do
    subject { described_class.create( :username => "foobar", :password => "foobar", :password_confirmation => "foobar" ); described_class.last }
    its( :crypted_password ) { should be_present }
    its( :password_salt ) { should be_present }
    its( :crypted_password ) { should_not == "foobar" }
    its( :password ) { should_not == "foobar" }
    it_behaves_like "password oracle"
  end

  it "fails if password confirmation is mismatch" do
    described_class.create( :username => "foobar", :password => "foobar", :password_confirmation => "barbaz" ).should be_invalid
  end

  it "fails if password confirmation is missing" do
    described_class.create( :username => "foobar", :password => "foobar" ).should be_invalid
  end

  context "legacy MD5 password" do
    subject { described_class.create :username => "foobar", :crypted_password => "$1$f8Qwor9I$bSkUziPv/xNI/.Vhb/NUr." }
    it_behaves_like "password oracle"
  end

  context "legacy DES password" do
    subject { described_class.create :username => "foobar", :crypted_password => "abVbJXzHUY99s" }
    it_behaves_like "password oracle"
    it "transitions password on successful validation" do
      subject.valid_password?( "foobar" )
      subject.crypted_password.should match( /\$1\$.{8}\$.{22}/ )
    end
  end
end
