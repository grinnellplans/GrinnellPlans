require 'spec_helper'

describe Notifier do

  before :each do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
  end

  after :each do
    ActionMailer::Base.deliveries.clear
  end

  it 'sends a welcome email' do
    username = 'littlebird'
    email = 'little@bird.me'
    password = 'tastyw0rms'
    Notifier.send_password(username, email, password).deliver
    sent = ActionMailer::Base.deliveries.first
    assert_equal 'Plan Created', sent.subject
    assert_equal email, sent.to[0]
    sent.body.should =~ /Your Plan has been created/
    sent.body.should =~ /#{password}/
  end

  it 'sends a confirmation email' do
    username = 'littlebird'
    email = 'little@bird.me'
    token = 'tastyw0rms'
    Notifier.confirm(username, email, token).deliver
    sent = ActionMailer::Base.deliveries.first
    assert_equal 'Plan Activation Link', sent.subject
    assert_equal email, sent.to[0]
    sent.body.should =~ /will expire in 24 hours/
  end

end
