require 'test_helper'
class UserMailerTest < ActionMailer::TestCase
  
  def teardown
    ActionMailer::Base.deliveries.clear
  end
  
  test "welcome email" do
    username = 'littlebird'
    email = 'little@bird.me'
    password = 'tastyw0rms'
    Notifier.send_password(username, email, password).deliver
    sent = ActionMailer::Base.deliveries.first
    assert_equal 'Plan Created', sent.subject
    assert_equal email, sent.to[0]
    assert_match 'Your Plan has been created!', sent.body
    assert_match  password, sent.body
  end

  test "confirmation email" do
    username = 'littlebird'
    email = 'little@bird.me'
    token = 'tastyw0rms'
    Notifier.confirm(username, email, token).deliver
    sent = ActionMailer::Base.deliveries.first
    assert_equal 'Plan Activation Link', sent.subject
    assert_equal email, sent.to[0]
    assert_match 'will expire in 24 hours', sent.body
  end
end
