class ApplicationController < ActionController::Base
  layout :layout_by_resource
  protect_from_forgery

  # You don't need these render methods. You can just use respond_to and respond_with to do the same thing. 
  # Look at this article: http://davidwparker.com/2010/03/09/api-in-rails-respond-to-and-respond-with/
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
  
  # finding a contact should always be scoped to user for security reasons. If you call Contact.find(id), it is easy for me to 
  # hack your app by sending in an id of a contact i don't own. Instead use current_user.contacts.find(id)
  # This comment is true in your other controllers as well. Everywhere you use Contact, replace it with current_user.contacts
  #
  # Really i don't see the reason for this method. It doesn't save any typing.
  def get_contact_from_id(id)
    Contact.find(id)
    # current_user.contacts.find(id)
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

