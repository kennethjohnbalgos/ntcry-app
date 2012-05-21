class GroupContactsController < ApplicationController
  # GET /group_contacts
  # GET /group_contacts.json
  def index
    @group_contacts = GroupContact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @group_contacts }
    end
  end

  # GET /group_contacts/1
  # GET /group_contacts/1.json
  def show
    @group_contact = GroupContact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group_contact }
    end
  end

  # GET /group_contacts/new
  # GET /group_contacts/new.json
  def new
    @group_contact = GroupContact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group_contact }
    end
  end

  # GET /group_contacts/1/edit
  def edit
    @group_contact = GroupContact.find(params[:id])
  end

  # POST /group_contacts
  # POST /group_contacts.json
  def create
    @group_contact = GroupContact.new(params[:group_contact])

    respond_to do |format|
      if @group_contact.save
        format.html { redirect_to @group_contact, notice: 'Group contact was successfully created.' }
        format.json { render json: @group_contact, status: :created, location: @group_contact }
      else
        format.html { render action: "new" }
        format.json { render json: @group_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /group_contacts/1
  # PUT /group_contacts/1.json
  def update
    @group_contact = GroupContact.find(params[:id])

    respond_to do |format|
      if @group_contact.update_attributes(params[:group_contact])
        format.html { redirect_to @group_contact, notice: 'Group contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_contacts/1
  # DELETE /group_contacts/1.json
  def destroy
    @group_contact = GroupContact.find(params[:id])
    @group_contact.destroy

    respond_to do |format|
      format.html { redirect_to group_contacts_url }
      format.json { head :no_content }
    end
  end
end
