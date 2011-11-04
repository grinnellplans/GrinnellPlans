class Notifier < ActionMailer::Base
  
  default :from => APP_CONFIG['from_address']
  
  def confirm username, email, token
    @username = username
    @token = token
    mail :to => email, :subject => "Plan Activation Link"
  end
  
  def send_password username, email, password
    @username = username
    @password = password
    mail :to => email, :subject => "Plan Created"
  end

end
