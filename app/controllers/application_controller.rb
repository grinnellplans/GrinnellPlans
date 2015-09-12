class ApplicationController < ActionController::Base
  protect_from_forgery

  # Filters added to this controller apply to all controllers in the application.
  # Likewise, all the methods added will be available for all controllers.
  helper :all # include all helpers, all the time
  helper_method :current_account, :current_account_session

  def current_account
    @current_account ||= current_account_session && current_account_session.record
  end

  def current_account_session
    @current_account_session ||= AccountSession.find
  end

  def require_user
    redirect_to login_path if current_account.nil?
  end

  def require_no_user
    redirect_to root_path if current_account.present?
  end

  def require_admin
    redirect_to root_path if current_account.nil? || !current_account.is_admin?
  end

  def load_autofingers
    @autofingers = current_account.interests_in_others.updated.where priority: session[:autofinger_level]
  end
end
