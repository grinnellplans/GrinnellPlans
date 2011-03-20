class PlansController < ApplicationController
  before_filter :require_user

  def edit
   @plan = current_account.plan
  end

  def update
    @plan = current_account.plan
    @plan.edit_text = params[:plan][:edit_text]
    if @plan.save
      redirect_to :action=>:show, :id => @plan.account.username
    else
      render :action => "edit"
    end
  end

  
  def show
      @account = Account.find_by_username(params[:username])
      if @account.blank?
        #search
      else
          # mark as read
          autofinger = Autofinger.where(:owner=>current_account.userid, :interest=> @account.userid ).first
          unless autofinger.blank?
            autofinger.updated = '0'
            autofinger.readtime = Time.now
            autofinger.save!
          end
      end
  end
  
  def search
    
  end
  
  def mark_as_read
  end

end
