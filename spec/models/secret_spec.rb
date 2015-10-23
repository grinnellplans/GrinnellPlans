require 'rails_helper'

describe Secret do
  before(:each) do
    @attributes = { secret_text: 'SCANDAL!' }
    @secret = Secret.new(@attributes)
  end

  it 'is valid with valid attributes' do
    expect(@secret).to be_valid
  end

  it 'is not valid without secret_text' do
    @secret.secret_text = nil
    expect(@secret).not_to be_valid
  end

  it 'is not valid when display is not in list of accepted options' do
    @secret.display_attr = 'asdf'
    expect(@secret).not_to be_valid
  end

  it 'is not valid when the secret is exceeds db limit for text length (16777215)' do
    @secret.secret_text = TOO_LONG_STRING
    expect(@secret).not_to be_valid
  end

  it 'is not valid when date not null before_create' do
    @secret = Secret.create(@attributes)
    expect(@secret.date).not_to be_nil
  end

  it 'is not valid when date_approved is not populated before_update' do
    @secret.save
    @secret.secret_text = 'fee'
    @secret.display_attr = 'yes'
    @secret.save
    expect(@secret.date_approved).not_to be_nil
  end

end
