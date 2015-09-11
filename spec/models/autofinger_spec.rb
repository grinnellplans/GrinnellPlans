require 'spec_helper'

describe Autofinger do
  it 'must have a priority' do
    owner = Account.create! username: 'owner', password: '123456', password_confirmation: '123456'
    interest = Account.create! username: 'interest', password: '123456', password_confirmation: '123456'
    expect(described_class.new(owner: owner.id, interest: interest.id, priority: nil)).to be_invalid
  end

  describe 'updated scope' do
    before do
      @updated = FactoryGirl.create :autofinger, updated: '1'
      @not_updated = FactoryGirl.create :autofinger, updated: '0'
    end
    subject { Autofinger.updated }
    it 'includes updated accounts' do
      expect(subject.exists?(@updated.id)).to be_truthy
    end
    it 'excludes un-updated accounts' do
      expect(subject.exists?(@not_updated.id)).to be_falsey
    end
  end

  describe 'priority validation' do
    it 'accepts priority 0' do
      expect(FactoryGirl.build :autofinger, priority: 0).to be_valid
    end
    it 'accepts priority 3' do
      expect(FactoryGirl.build :autofinger, priority: 3).to be_valid
    end

    it 'rejects priority > 3' do
      expect(FactoryGirl.build :autofinger, priority: 4).not_to be_valid
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
