class ApplicationController < ActionController::Base
  
  before_filter :authenticate_user!
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
  
  def setup_address_book
    @order = session[:order]
    @conditions = session[:conditions]
    @contacts = current_user.contacts.where(@conditions).order(@order)
    @groups = current_user.groups.order('position')
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

