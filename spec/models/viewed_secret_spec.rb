require 'rails_helper'

describe ViewedSecret do
  it 'must have an account' do
    viewed_secret = described_class.create(account: nil).should be_invalid
  end
end
# == Schema Information
#
# Table name: viewed_secrets
#
#  userid :integer         not null, primary key
#  date   :datetime
#
