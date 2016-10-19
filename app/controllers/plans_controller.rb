class PlansController < ApplicationController
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
    username = params[:id]
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
    q = params[:q]
    @account = Account.find_by_username(q)
    if !@account.blank? && params[:follow_usernames]
      redirect_to read_plan_path(id: @account.username)
    elsif q.present?
      matching_plans = Plan.where("edit_text LIKE ?", "%#{q}%").joins(:account).order('accounts.username').includes(:account)
      @results = matching_plans.inject([]) do |results, plan|
        matches = []
        last = 0
        text = Sanitize.clean(plan.plan, elements: ["br"])
        while (i = text.index(q, last)).present?
          start_pos = text.index(/\s/, [0, i - 100].max)
          end_pos = text.index(/\s/, i + q.length)
          end_pos = [end_pos, i + q.length + 120].compact.min
          matches << { text: text.slice(start_pos, end_pos).html_safe, pos: [i - start_pos, i + q.length - start_pos] }
          last = end_pos
        end
        results << { plan: plan, matches: matches }
      end
    end
  end

  def planwatch
    @hours = if params[:hours].to_i < 1 then 12 else params[:hours].to_i end
    @plans = Account.where(changed: (Time.now - @hours.hours)..Time.now).order(changed: :desc)
  end

  def genesis
    @days = if params[:days].to_i < 1 then 5 else params[:days].to_i end
    @plans = Account.where(created: (Time.now - @days.days)..Time.now).order(created: :desc)
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
