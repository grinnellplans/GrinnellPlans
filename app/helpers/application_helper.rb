module ApplicationHelper
  def show_autofinger(priority)
    html = ""
    autofingers = Autofinger.where(:owner=>@current_account.userid, :priority=>priority) unless @current_account.blank?
    for autofinger in autofingers
      #TODO fix plan routing
      html << link_to("[#{autofinger.subject_of_interest.username}]", {:controller=>:plans, :action=>:show, :id =>autofinger.subject_of_interest.username})
      html << "<br />"
    end
    return html.html_safe
  end
  
end
