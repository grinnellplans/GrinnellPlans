require File.expand_path('../../mailers/notifier.rb', __FILE__)

class AccountsController < ApplicationController

  def index
  end

  def new
  end

  def create_random_token length=8
    characters = ('A'..'Z').to_a + (0..9).to_a
    characters -= ['B'] # B and 8 look very similar
    characters.sort_by{rand}
    (0..length).map{characters.sample}.join
  end

  def confirm_email
  end
  
  def create
    @account = params[:account]
    
    if Account.find_by_username(@account["username"])
      @account_already_exists = true
      return
    end
    
    tentative_account = TentativeAccount.find_by_username(@account["username"])
    if  tentative_account && tentative_account.updated_at > (Time.now - 1.day)
      @account_exists_but_not_confirmed = true
      return
    end
    
    tentative_account.delete! if tentative_account
    @user_email = "#{@account['username']}@#{@account['email_domain']}"
    ta = TentativeAccount.create (:username => @account["username"],
                                  :user_type => @account["user_type"],
                                  :email => @user_email,
                                  :confirmation_token => create_random_token)
    
    # send email
    confirmation_email = Notifier.confirm ta.username, ta.email, ta.confirmation_token
    confirmation_email.deliver
    @confirmation_email_sent = true
  end

  def confirm
    # the creation of an account and the deletion of the tentative account should be transactional
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
