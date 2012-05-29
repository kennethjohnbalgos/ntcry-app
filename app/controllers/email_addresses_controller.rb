class EmailAddressesController < ApplicationController

  def new
    @email_address = EmailAddress.new
    @contact = current_user.contacts.find(params[:contact_id])
    @total_email = @contact.valid_email_addresses.count
    renderJS
  end

  def edit
    @email_address = current_user.email_addresses.find(params[:id])
  end

  def create
    @success = false
    if params[:email_address][:email].present?
      if !(params[:email_address][:email].strip =~ /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/)
        @notice = "Invalid Email Address format"
      elsif EmailAddress.exists?(contact_id: params[:email_address][:contact_id], email: params[:email_address][:email])
        @notice = "Email Address already exists"
      else
        if params[:email_address][:main] == "1"
          sql = ActiveRecord::Base.connection()
          sql.execute("UPDATE email_addresses SET main = 0 WHERE contact_id = #{params[:email_address][:contact_id]}")
        end
        params[:email_address][:user_id] = current_user.id
        params[:email_address][:provider] = params[:email_address][:email].split("@").last
        @email_address = EmailAddress.create(params[:email_address])
        @notice = "Email Address was successfully saved"
        @contact = current_user.contacts.find(params[:email_address][:contact_id])
        @contact.status = 'active'
        @contact.save
        if @contact.email_addresses.count == 1
          @email_address.main = 1
          @email_address.save
        end
        @email_address = nil
        @success = true
      end
    else
      @notice = "Please enter the Email Address"
    end
    
    setup_address_book
    renderJS
  end
  
  def change_primary
    @success = false
    @contact = current_user.contacts.find(params[:primary_email_form][:contact_id])
    if @contact.present?
      @email = @contact.email_addresses.find(params[:primary_email_form][:id])
      if @email.present?
        if @email.main == 0
          sql = ActiveRecord::Base.connection()
          sql.execute("UPDATE email_addresses SET main = 0 WHERE contact_id = #{@contact.id}")
          @email.main = 1
          @email.save
          @notice = "Primary Email successfully changed"
          @success = true
        else
          @notice = "Email Address is already Primary"
        end
      else
        @notice = "Invalid contact's Email Address"
      end
    else
      @notice = "Invalid contact's Email Address"
    end
    
    setup_address_book
    renderJS
  end

  def request_delete
    @email = current_user.email_addresses.find(params[:id])
    if @email.main == 0
      @contact = current_user.contacts.find(@email.contact_id)
      @notice = "Confirm to delete an Email Address"
      @success = true
    else
      @notice = "You can't delete a Primary Email"
      @success = false
    end
    renderJS
  end
  
  def confirmed_delete
    @email = EmailAddress.find(params[:id])
    @contact = current_user.contacts.find(@email.contact_id)
    @email.status = 'deleted'
    @email.save
    renderJS
  end
  
end
