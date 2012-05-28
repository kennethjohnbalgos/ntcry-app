class ContactsController < ApplicationController
  before_filter :authenticate_user! # move this to ApplicationController so you don't have to remeber to put it in each controller

  # GET /contacts
  # GET /contacts.json
  def index
    session[:order] = "first_name" unless session[:order].present?
    @order = session[:order]
    #@order = session[:order] ||= 'first_name'

    session[:conditions] = "user_id = #{current_user.id} AND status <> 'deleted'" unless session[:conditions].present?
    @conditions = session[:conditions]
    @contacts = Contact.where(@conditions).order(@order)
    renderHTML(@contacts)
  end
  
  def sort
    session[:order] = params[:order]
    @order = session[:order]
    @conditions = session[:conditions]
    @contacts = Contact.where(@conditions).order(@order)
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
    renderJS
  end

  # POST /contacts
  # POST /contacts.json
  def create

    #################
    #  replace this #
    params[:contact][:user_id] = current_user.id # this isn't needed if you use current_user.contacts.create
    params[:contact][:source] = "Noticery"
    params[:contact][:source_reference] = ""
    @contact = Contact.create(params[:contact])

    # with this    #
    @contact = current_user.contacts.create(params[:contact].merge(source: 'Noticery', source_reference: ''))
    ################

    @notice = 'Contact was successfully created'
    
    #################
    #  replace this #
    @add_another = params[:extra_add_another]
    if @add_another.to_i == 1
      @contact = nil
      @contact = Contact.new 
    end

    # with this    #
    @contact = Contact.new if params[:extra_add_another] == '1'
    ################


    @order = session[:order]
    @conditions = session[:conditions]
    @contacts = Contact.where(@conditions).order(@order)

    renderJS
  end

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    @contact = Contact.find(params[:id])
    # your need to check and see if the update worked
    # if @contact.update_attributes(params[:contact])
    @contact.update_attributes(params[:contact])

      @notice = 'Contact was successfully updated'
    # else
      # error message, record not valid
    # end
    
    #################
    #  replace this #
    if @contact.status == 'imported'
      @contact.status = 'active'
      @contact.save
    end
    # with this    #
    @contact.update_attribute(:status, 'active') if @contact.status == 'imported'
    ################

    
    @add_another = params[:extra_add_another]
    
    @order = session[:order]
    @conditions = session[:conditions]
    @contacts = Contact.where(@conditions).order(@order)
    
    renderJS
  end
  
  def request_delete
    @ids = params[:contact_delete][:ids].split(',')
    renderJS
  end

  def confirmed_delete
    @ids_raw = params[:confirm_delete][:ids]

    #################
    #  replace this #
    sql = ActiveRecord::Base.connection()
    sql.execute("UPDATE contacts SET status = 'deleted' WHERE id IN (#{@ids_raw})")
    # with this    #
    Contact.where(id: @ids_raw).update_all("status = 'deleted'") # http://api.rubyonrails.org/classes/ActiveRecord/Relation.html#method-i-update_all
    ################

    @notice = "Selected contacts successfully deleted"
    @order = session[:order]
    @conditions = session[:conditions]
    @contacts = Contact.where(@conditions).order(@order)
    
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
