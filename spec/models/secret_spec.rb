require 'spec_helper'

describe Secret do
  before(:each) do
    @attributes = { secret_text: 'SCANDAL!' }
    @secret = Secret.new(@attributes)
  end

  it 'is valid with valid attributes' do
    @secret.should be_valid
  end

  it 'is not valid without secret_text' do
    @secret.secret_text = nil
    @secret.should_not be_valid
  end

  it 'is not valid when display is not in list of accepted options' do
    @secret.display_attr = 'asdf'
    @secret.should_not be_valid
  end

  it 'is not valid when the secret is exceeds db limit for text length (16777215)' do
    @secret.secret_text = TOO_LONG_STRING
    @secret.should_not be_valid
  end

  it 'is not valid when date not null before_create' do
    @secret = Secret.create(@attributes)
    !@secret.date.should_not.nil?
  end

  it 'is not valid when date_approved is not populated before_update' do
    @secret.save
    @secret.secret_text = 'fee'
    @secret.save
    !@secret.date_approved.should_not.nil?
  end
end
# == Schema Information
#
# Table name: secrets
#
#  secret_id     :integer         not null, primary key
#  secret_text   :text
#  date          :datetime
#  display       :string(5)
#  date_approved :datetime
#
