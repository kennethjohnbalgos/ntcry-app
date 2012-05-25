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
  
end
