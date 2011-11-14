class PlansController < ApplicationController
  before_filter :require_user

  def edit
   @plan = current_account.plan
  end

  def update
    @plan = current_account.plan
    @plan.edit_text = params[:plan][:edit_text]
    if @plan.save
      redirect_to :action => :show, :id => @plan.account.username
    else
      render :action => "edit"
    end
  end

  
  def show
      username = params[:id] || current_account.username
      @account = Account.find_by_username(username)
      if @account.blank?
        redirect_to :action => :search, :id => username
      else
        # mark as read
        Autofinger.mark_as_read(current_account.userid, @account.userid)
      end
  end
  
  def search
    
  end

end
