class PlansController < ApplicationController
  before_filter :require_user, :load_autofingers

  def edit
    @plan = current_account.plan
  end

  def update
    @plan = current_account.plan
    @plan.edit_text = unsafe_params[:plan][:edit_text]
    if @plan.save
      flash[:notice] = "Plan updated successfully"
      redirect_to read_plan_path(id: @plan.account.username)
    else
      render action: 'edit'
    end
  end

  def show
    username = unsafe_params[:id] || current_account.username
    @account = Account.find_by_username(username)
    if @account.blank?
      redirect_to action: :search, id: username
    else
      Autofinger.mark_plan_as_read(current_account.userid, @account.userid)
    end
  end

  def mark_level_as_read
    Autofinger.mark_level_as_read(current_account.userid, unsafe_params[:level])
    redirect_to unsafe_params[:return_to]
  end

  def set_autofinger_level
    session[:autofinger_level] = unsafe_params[:level]
    redirect_to unsafe_params[:return_to]
  end

  def search
    @account = Account.find_by_username(unsafe_params[:id])
    if !@account.blank?
      redirect_to read_plan_path(id: @account.username)
    else
      # TODO
    end
  end

  def set_autofinger_subscription
    owner = current_account
    interest = Account.find_by_username(unsafe_params[:id])
    autofinger = owner.interests_in_others.find_or_create_by(interest: interest.id)
    success = autofinger.update_attributes(priority: unsafe_params[:priority])
    if success
      if unsafe_params[:priority] == '0'
        notice = 'User was removed from your autoread list.'
      else
        notice = "User is now on your autoread list with priority level of #{unsafe_params[:priority]}."
      end
    else
      notice = "Could not change autoread priority. If this happens more than once, contact the Plans admins at grinnellplans@gmail.com."
    end
    redirect_to :back, notice: notice
  end
end
