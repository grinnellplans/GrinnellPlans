module AutofingerHelper
  def current_autoread_level
    (session[:autofinger_level] || 1).to_i
  end

  def current_autoread?(level)
    level == current_autoread_level
  end
end
