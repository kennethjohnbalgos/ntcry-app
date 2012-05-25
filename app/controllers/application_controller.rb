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

  protected

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
  
end

