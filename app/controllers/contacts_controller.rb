class ContactsController < ApplicationController
  
  def index
    session[:order] = "first_name" unless session[:order].present?
    session[:conditions] = "status <> 'deleted'" unless session[:conditions].present?
    @order = session[:order] ||= 'first_name'
    setup_address_book
    renderHTML(@contacts)
  end
  
  def sort
    session[:order] = params[:order]
    setup_address_book
    renderJS
  end

  def show
    @contact = Contact.find(params[:id])
    renderJS
  end

  def new
    @contact = Contact.new
    renderJS
  end

  def edit
    @contact = Contact.find(params[:id])
    renderJS
  end

  def create
    @contact = current_user.contacts.create(params[:contact].merge(source: 'Noticery', source_reference: ''))
    @notice = 'Contact was successfully created'
    @contact = Contact.new if params[:extra_add_another] == '1'
    setup_address_book
    renderJS
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update_attributes(params[:contact])
      @success = true
      @notice = 'Contact was successfully updated'
      @contact.update_attribute(:status, 'active') if @contact.status == 'imported'
    else
      @success = false
      @notice = 'Saving failed, please verify the fields'
    end
    @add_another = params[:extra_add_another]
    setup_address_book
    renderJS
  end
  
  def request_delete
    @ids = params[:contact_delete][:ids].split(',')
    renderJS
  end

  def confirmed_delete
    @ids_raw = params[:confirm_delete][:ids]
    Contact.where(id: @ids_raw).update_all("status = 'deleted'")
    @notice = "Selected contacts successfully deleted"
    setup_address_book
    renderJS
  end

end
