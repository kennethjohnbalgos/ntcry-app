class ContactsController < ApplicationController
  before_filter :authenticate_user!
  # GET /contacts
  # GET /contacts.json
  def index
    
    session[:order] = "first_name" unless session[:order].present?
    @order = session[:order]
    Rails.logger.info ">>> #{@order.to_json}"
    @contacts = Contact.where(user_id: current_user.id).order(@order)
    renderHTML(@contacts)
  end
  
  def sort
    session[:order] = params[:order]
    @order = session[:order]
    @contacts = Contact.where(user_id: current_user.id).order(@order)
    renderJS
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @contact = Contact.find(params[:id])

    renderJS
  end

  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.new

    renderJS
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.json
  def create
    params[:contact][:user_id] = current_user.id
    params[:contact][:source] = "Noticery"
    params[:contact][:source_reference] = ""
    @contact = Contact.create(params[:contact])
    @notice = 'Contact was successfully created'
    
    @order = session[:order]
    @contacts = Contact.where(user_id: current_user.id).order(@order)
    
    renderJS
  end

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    @contact = Contact.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to contacts_path, notice: 'Contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def request_delete
    @ids = params[:contact_delete][:ids].split(',')
    renderJS
  end

  def confirmed_delete
    @ids = params[:confirm_delete][:ids].split(',')
    @ids.each do |id|
      contact = get_contact_from_id(id)
      contact.destroy
    end
    
    @notice = "Selected contacts successfully deleted"
    @order = session[:order]
    @contacts = Contact.where(user_id: current_user.id).order(@order)
    
    renderJS
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end
end
