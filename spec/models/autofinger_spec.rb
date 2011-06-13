require 'spec_helper'

describe Autofinger do
  it "must have a priority" do
    owner = Account.create! :username => "owner", :password => "123456", :password_confirmation => "123456"
    interest = Account.create! :username => "interest", :password => "123456", :password_confirmation => "123456"
    autofinger = described_class.create(:owner => owner, :interest => interest, :priority => nil).should be_invalid
  end
end

# == Schema Information
#
# Table name: autofinger
#
#  owner    :integer(2)      default(0), not null
#  interest :integer(2)      default(0), not null
#  priority :integer(1)
#  updated  :string(1)
#  updtime  :datetime
#  readtime :datetime
#

