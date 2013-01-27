class PasswordResetsController < ApplicationController
  before_filter :require_no_user  
  before_filter :load_account_using_perishable_token, :only => [:edit, :update]  
  
  def new  
    render  
  end  
  
  def create  
    @account = Account.find_by_email(params[:email])  
    if @account  
      @account.deliver_password_reset_instructions!  
      flash[:notice] = "Instructions to reset your password have been emailed to you. Please check your email."
      redirect_to login_path
    else  
      flash[:notice] = "No account was found with that email address"  
      render :action => :new  
    end  
  end
    
  def edit  
    render  
  end  

  def update  
    @account.password = params[:account][:password]  
    @account.password_confirmation = params[:account][:password_confirmation]  
    if @account.save
      flash[:notice] = "Password successfully updated"  
      redirect_to root_path  
    else  
      render :action => :edit  
    end  
  end

  private  
  
  def load_account_using_perishable_token  
    @account = Account.find_using_perishable_token(params[:id])  
    unless @account  
      flash[:notice] = "We're sorry, but we could not locate your account. " +  
      "If you are having issues try copying and pasting the URL " +  
      "from your email into your browser or restarting the " +  
      "reset password process."  
      redirect_to login_path  
    end
  end  
end
