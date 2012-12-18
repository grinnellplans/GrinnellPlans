require 'spec_helper'

describe Autofinger do
  it "must have a priority" do
    owner = Account.create! :username => "owner", :password => "123456", :password_confirmation => "123456"
    interest = Account.create! :username => "interest", :password => "123456", :password_confirmation => "123456"
    autofinger = described_class.create(:owner => owner, :interest => interest, :priority => nil).should be_invalid
  end

  describe "updated scope" do
    before do
      @updated = FactoryGirl.create :autofinger, :updated => "1"
      @not_updated = FactoryGirl.create :autofinger, :updated => "0"
    end
    subject { Autofinger.updated }
    it "includes updated accounts" do
      subject.exists?(@updated.id).should be_true
    end
    it "excludes un-updated accounts" do
      subject.exists?(@not_updated.id).should be_false
    end
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

