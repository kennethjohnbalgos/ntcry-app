module ApplicationHelper
  
  def head_icon_link(icon,text)
    el = ""
    el += "<div class='link_space'>"
      el += "<img src='#{asset_path icon}' class='icon'>"
      el += "<br/>"
      el += "#{text}"
    el += "</div>"
    raw(el)
  end
  
  def date_format_c(date)
    date.to_date.strftime("%B %d, %Y")
  end
  
  def get_contact_from_id(id)
    Contact.find(id)
  end
  
  def get_email_from_id(id)
    EmailAddress.find(id)
  end
  
end
