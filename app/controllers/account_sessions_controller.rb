class AccountSessionsController < ApplicationController

  def new
    @session = AccountSession.new
  end

  def create
    @session = AccountSession.new params[ :account_session ]
    if @session.save
      session[:autofinger_level] = 1
      redirect_to "/"
    else
      render :action => :new
    end
  end

  def destroy
    current_account_session.destroy
    flash[ :notice ] = "You've been logged out."
    redirect_to new_account_session_path
  end
end