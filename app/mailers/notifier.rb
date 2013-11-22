class Notifier < ActionMailer::Base

  default from: APP_CONFIG['from_address']
  default_url_options[:host] = APP_CONFIG['domain_name']

  def confirm(username, email, token)
    @username = username
    @token = token
    mail to: email, subject: 'Plan Activation Link'
  end

  def send_password(username, email, password)
    @username = username
    @password = password
    mail to: email, subject: 'Plan Created'
  end

  def password_reset_instructions(account)
    @account = account
    mail to: account.email, subject: 'Plan Password Reset Instructions'
  end

end
