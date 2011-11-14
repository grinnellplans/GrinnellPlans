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
    if current_account.nil?
      redirect_to new_account_session_path
    end
  end
  
  def  require_admin
    if !true # TODO determine how a user is admin  
      redirect_to new_account_session_path
    end
  end
  
  def load_autofingers
    @autofingers = Autofinger.where(:owner=>@current_account.userid, :priority=> session[:autofinger_level], :updated => "1")
  end
  
end
