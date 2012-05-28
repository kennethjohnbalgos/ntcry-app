class ImportController < ApplicationController
  
  def new
    renderJS
  end
  
  def connect
    @provider_raw = params[:provider]
    @provider = "Google" if @provider_raw == 'gmail'
    @provider = "Yahoo!" if @provider_raw == 'yahoo'
    renderJS
  end
  
  def reader
    @contacts = request.env['omnicontacts.contacts']
    provider = get_provider_from_uri()
    
    # Initialize Counters
    @imported = 0
    @duplicate = 0
    
    @contacts.each do |contact|
      
      # Set Values
      source = 'Google' if provider == 'gmail'
      source = 'Yahoo' if provider == 'yahoo'
      email = contact[:email]
      user_id = current_user.id
      full_name = contact[:name].present? ? contact[:name] : get_name_from_email(contact[:email])
      status = contact[:name].present? ? 'active' : 'imported'
      
      validate_email = EmailAddress.find_by_email_and_user_id(email,user_id)
      if validate_email.present?
        validate_contact = Contact.find_by_id_and_user_id(validate_email.contact_id,user_id)
        if validate_contact.status == 'deleted'
          old_contact = validate_contact
          old_contact.status = 'imported'
          old_contact.save
          old_email = old_contact.email_addresses.find_by_email_and_user_id(email,user_id)
          if old_email.present?
            old_email.status = 'imported'
            old_email.save
          else
            new_email = EmailAddress.create(contact_id: old_contact.id, email: email, status: 'imported', main: 1, user_id: user_id)
          end
          @imported += 1
        elsif validate_contact.full_name.downcase.strip == full_name.downcase.strip
          @duplicate += 1
        end 
      else
        new_contact = Contact.create(full_name: full_name, user_id: user_id, status: status, source: source)
        new_email = EmailAddress.create(contact_id: new_contact.id, email: email, status: 'imported', main: 1, user_id: user_id)
        @imported += 1
      end
    end
    if @imported == 0 && @duplicate == 0
      flash[:notice] = "No contacts found on your #{source} account"
    elsif @imported == 0 && @duplicate > 0
      flash[:notice] = "All contacts are already imported"
    elsif @duplicate == 0 && @imported > 0
      flash[:notice] = "All #{@imported} contacts are now imported"
    else
      flash[:notice] = "#{@imported} contacts are now imported---#{@duplicate} contacts are duplicate and ignored"
    end
    redirect_to controller: 'contacts'
  end
  
  private
  
  def get_provider_from_uri
    request.url.split('?').first.split('/').last.split('-').first
  end
  
  def get_name_from_email(email)
    email.split('@').first.gsub("_"," ").gsub("."," ").gsub("-"," ").titleize
  end
end
