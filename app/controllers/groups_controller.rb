class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  def new
    @group = Group.new
    renderJS
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
    renderJS
  end
  
  def create
    position = current_user.groups.count + 1
    @group = current_user.groups.new(params[:group].merge(position: position))
    if @group.save
      @add_another = params[:extra_add_another]
      @group = Group.new if @add_another == '1'
      @notice = 'Group was successfully created'
      @success = true
    else
      @notice = 'Saving failed, please verify the fields'
      @success = false
    end
    
    setup_address_book
    renderJS
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end
end
