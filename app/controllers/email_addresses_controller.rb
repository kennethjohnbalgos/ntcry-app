class EmailAddressesController < ApplicationController
  # GET /email_addresses
  # GET /email_addresses.json
  def index
    @email_addresses = EmailAddress.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @email_addresses }
    end
  end

  # GET /email_addresses/1
  # GET /email_addresses/1.json
  def show
    @email_address = EmailAddress.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @email_address }
    end
  end

  # GET /email_addresses/new
  # GET /email_addresses/new.json
  def new
    @email_address = EmailAddress.new
    @total_email = EmailAddress.where(contact_id: params[:contact_id]).count
    renderJS
  end

  # GET /email_addresses/1/edit
  def edit
    @email_address = EmailAddress.find(params[:id])
  end

  # POST /email_addresses
  # POST /email_addresses.json
  def create
    if params[:email_address][:email].present?
      if !(params[:email_address][:email].strip =~ /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/)
        @notice = "Invalid Email Address format"
        @success = false
      elsif EmailAddress.exists?(contact_id: params[:email_address][:contact_id], email: params[:email_address][:email])
        @notice = "Email Address already exists"
        @success = false
      else
        if params[:email_address][:main] == 1
          sql = ActiveRecord::Base.connection()
          sql.execute("UPDATE email_addresses SET main = 0 WHERE contact_id = #{params[:email_address][:contact_id]}")
        end
        @email_address = EmailAddress.create(params[:email_address])
        @notice = "Email Address was successfully saved"
        @contact = get_contact_from_id(params[:email_address][:contact_id])
        @contact.status = 'active'
        @contact.save
        unless @contact.email_addresses.count > 1
          @email_address.main = 1
          @email_address.save
        end
        @email_address = nil
        @success = true
      end
    else
      @notice = "Please enter the Email Address"
      @success = false
    end
    renderJS
  end

  # PUT /email_addresses/1
  # PUT /email_addresses/1.json
  def update
    @email_address = EmailAddress.find(params[:id])

    respond_to do |format|
      if @email_address.update_attributes(params[:email_address])
        format.html { redirect_to @email_address, notice: 'Email address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @email_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /email_addresses/1
  # DELETE /email_addresses/1.json
  def destroy
    @email_address = EmailAddress.find(params[:id])
    @email_address.destroy

    respond_to do |format|
      format.html { redirect_to email_addresses_url }
      format.json { head :no_content }
    end
  end
end
