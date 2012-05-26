class ApplicationController < ActionController::Base
  layout :layout_by_resource
  protect_from_forgery

  def renderJS
  	respond_to do |format|
    	format.js if request.xhr?
			format.html
    end
  end
  
  def renderHTML(results)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: results }
    end
  end
  
  def get_contact_from_id(id)
    Contact.find(id)
  end

  protected

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
  
end

