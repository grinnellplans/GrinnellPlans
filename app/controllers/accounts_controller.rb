require File.expand_path('../../mailers/notifier.rb', __FILE__)

class AccountsController < ApplicationController

  def index
  end

  def new
  end

  def create_random_token length=8
    characters = ('A'..'Z').to_a + (0..9).to_a
    characters -= ['B'] # B and 8 look very similar
    characters -= ['O'] # O and 0 look very similar
    characters.sort_by{rand}
    (0..length).map{characters.sample}.join
  end

  def send_confirmation_email username, email, token
    confirmation_email = Notifier.confirm username, email, token
    confirmation_email.deliver
  end

  def create
    @account = params[:account]
    
    @username = @account["username"]
    @user_email = "#{@account['username']}@#{@account['email_domain']}"
    
    if Account.find_by_username(@account["username"])
      @account_already_exists = true
      return
    end
    
    tentative_account = TentativeAccount.find_by_username(@account["username"])
    if  tentative_account && tentative_account.created_at > (Time.now - 1.day)
      @account_exists_but_not_confirmed = true
      return
    end
    
    tentative_account.delete if tentative_account
    ta = TentativeAccount.create( :username => @username,
                                  :user_type => @account["user_type"],
                                  :email => @user_email,
                                  :confirmation_token => create_random_token)
    
    # send email
    send_confirmation_email ta.username, ta.email, ta.confirmation_token
    @confirmation_email_sent = true
  end
  
  #TODO: replace all the booleans and hardcoded view logic with better notifications and messaging
  
  def confirm
    token = params[:token]
    ta = TentativeAccount.find_by_confirmation_token(token)
    
    if !ta || ta.created_at < (Time.now - 1.day)
      redirect_to :action => 'new' 
    else
      password = SecureRandom.hex(10)
      email = Notifier.send_password ta.username, ta.email, password
      ActiveRecord::Base.transaction do
        a = Account.create( :username => ta.username,
                            :email => ta.email, 
                            :user_type => ta.user_type,
                            :password => password,
                            :password_confirmation => password )
        ta.delete
      end
      email.deliver
    end
  end
  
  def resend_confirmation_email
    @username = params[:username]
    render :new if !@username
    
    ta = TentativeAccount.find_by_username(@username)
    render :new if !ta
    
    send_confirmation_email ta.username, ta.email, ta.confirmation_token
    @user_email = ta.email
    @confirmation_email_sent = true
  end

  def reset_password
    # generate a captcha
    # once verified human, reset password and send email
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
end
