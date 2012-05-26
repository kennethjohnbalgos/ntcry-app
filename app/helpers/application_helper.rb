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
  
  def get_contact_from_id(id)
    Contact.find(id)
  end
  
end
