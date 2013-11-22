require File.expand_path('../../mailers/notifier.rb', __FILE__)

class AccountsController < ApplicationController

  def new
    @allowed_domains = APP_CONFIG['email_domains'].map { |d| [d] }
  end

  def create
    @account = params[:account]
    @username = @account['username']
    @user_email = "#{@account['username']}@#{@account['email_domain']}"

    if Account.find_by_username(@account['username'])
      @account_already_exists = true
      return
    end

    if not APP_CONFIG['email_domains'].include? @account['email_domain']
      redirect_to action: 'new'
    end

    tentative_account = TentativeAccount.find_by_email(@user_email)
    if  tentative_account && tentative_account.created_at > (Time.now - 1.day)
      @account_exists_but_not_confirmed = true
      @user_email = tentative_account.email
      return
    end

    tentative_account.delete if tentative_account
    ta = TentativeAccount.create(username: @username,
                                 user_type: @account['user_type'],
                                 email: @user_email,
                                 confirmation_token: Account.create_random_token)

    # send email
    send_confirmation_email ta.username, ta.email, ta.confirmation_token
    @confirmation_email_sent = true
  end

  def confirm
    token = params[:token]
    ta = TentativeAccount.find_by_confirmation_token(token)

    if !ta || ta.created_at < (Time.now - 1.day)
      flash[:notice] = 'This confirmation token has expired. Please register again.'
      redirect_to action: 'new'
    else
      password = SecureRandom.hex(10)
      account = Account.create_from_tentative ta, password
      if account
        email = Notifier.send_password ta.username, ta.email, password
        email.deliver
        current_account_session.destroy
        @account_created = true
      end
    end
  end

  def resend_confirmation_email
    @username = params[:username]
    redirect_to action: 'new' if !@username

    ta = TentativeAccount.find_by_username(@username)
    redirect_to action: 'new' if !ta

    send_confirmation_email ta.username, ta.email, ta.confirmation_token
    @user_email = ta.email
    @confirmation_email_sent = true
  end

  def reset_password # TODO: implement
    # generate a captcha
    # once verified human, reset password and send email
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def send_confirmation_email(username, email, token)
    confirmation_email = Notifier.confirm username, email, token
    confirmation_email.deliver
  end
end
