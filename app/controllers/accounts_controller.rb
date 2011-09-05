class AccountsController < ApplicationController

  def index
  end

  def new
    @account = Account.new
  end

  def create
    @account = params[:account]
    # if the account already exists, complain
    # if the account has not been confirmed, complain with send another confirmation button
    # otherwise, make a new unconfirmed account and send confirmation email
  end

  def confirm
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
