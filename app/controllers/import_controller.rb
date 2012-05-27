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
    provider = request.url.split('?').first.split('/').last.split('-').first
    @contacts.each do |contact|
      source = 'Google' if provider == 'gmail'
      source = 'Yahoo' if provider == 'yahoo'
      email = contact[:email]
      if contact[:name].present?
        name = contact[:name]
        status = 'active'
      else
        name = contact[:email].split('@').first.gsub("_"," ").gsub("."," ").titleize
        status = 'imported'
      end
      @new_contact = Contact.create(full_name: name, user_id: current_user.id, status: status, source: source)
      @new_email = EmailAddress.create(contact_id: @new_contact.id, email: email, status: 'imported', main: 1)
      puts ">>>> New Contact: #{@new_contact.to_json}"
      puts ">>>> New Email: #{@new_email.to_json}"
    end
  end
end
