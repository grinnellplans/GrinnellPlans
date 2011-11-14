require 'test_helper'

class UserRegistrationTest < ActionDispatch::IntegrationTest

  test "create new user and log in" do
    # go to landing page
    get '/'
    assert_response 302
    follow_redirect!
    assert_template 'account_sessions/new'
    assert_match /\/register/, @response.body
    
    # go to registration page
    get '/register'
    assert_response :success
    assert_template 'accounts/new'
    
    # fill in the details
    account = { :username => 'plans', 
                :email_domain => 'blop.blop', 
                :user_type => 'student' }
    post 'accounts#create', { :account => account }
    assert_response :success
    assert_template 'accounts/create'
    assert_select 'p', /was just sent to plans@blop.blop/
    
    # check email
    email = ActionMailer::Base.deliveries.pop
    assert_equal 'Plan Activation Link', email.subject
    assert_equal 'plans@blop.blop', email.to[0]
    assert_match 'will expire in 24 hours', email.body

    # parse token and call confirm with supplied
    token = /token=(.*)/.match(email.body.raw_source)[1]
    get 'accounts/confirm', { :token => token }
    assert_response :success
    assert_select 'p', /Thank you for confirming your email!/
    
    # check email
    email = ActionMailer::Base.deliveries.pop
    assert_equal 'Plan Created', email.subject
    assert_equal 'plans@blop.blop', email.to[0]
    assert_match 'Your Plan has been created!', email.body

    # parse password from welcome email
    password = /Intial Password: (.*)/.match(email.body.raw_source)[1]

    # log in with password
    get '/'
    follow_redirect!
    assert_response :success

    account_session = { :username => 'plans', :password => password }
    post 'user#login', { :account_session => account_session }
    follow_redirect!
    assert_response :success
    assert_match /Last login/, @response.body
    assert_match /Log out/, @response.body
  end

end
