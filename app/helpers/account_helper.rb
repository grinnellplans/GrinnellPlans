module AccountHelper
  def user_stylesheet_url(account)
    return nil if account.nil?
    return account.custom_stylesheet.stylesheet if account.custom_stylesheet.present?
    return nil if account.style.nil?
    stylesheet_url(account.style.path.sub /^styles\//, '')
  end
end
