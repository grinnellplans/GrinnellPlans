require 'spec_helper'

describe Autofinger do
  it "must have a priority" do
    owner = Account.create! :username => "owner", :password => "123456", :password_confirmation => "123456"
    interest = Account.create! :username => "interest", :password => "123456", :password_confirmation => "123456"
    autofinger = described_class.create(:owner => owner, :interest => interest, :priority => nil).should be_invalid
  end
end
