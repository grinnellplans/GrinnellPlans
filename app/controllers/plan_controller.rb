class PlanController < ApplicationController
  
  def edit
   @plan = current_account.plan
  end
  
  def update
    @plan = current_account.plan
    @plan.edit_text = params[:plan][:edit_text]
    if @plan.save
      redirect_to :action=>:read, :username => @plan.account.username
    else
      render :action => "edit"
    end
  end
  
  def read
      @plan = Account.find_by_username(params[:username]).plan
      # TODO mark as read
  end
  
end