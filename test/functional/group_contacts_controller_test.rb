require 'test_helper'

class GroupContactsControllerTest < ActionController::TestCase
  setup do
    @group_contact = group_contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_contact" do
    assert_difference('GroupContact.count') do
      post :create, group_contact: { active: @group_contact.active, contact_id: @group_contact.contact_id, group_id: @group_contact.group_id, position: @group_contact.position }
    end

    assert_redirected_to group_contact_path(assigns(:group_contact))
  end

  test "should show group_contact" do
    get :show, id: @group_contact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_contact
    assert_response :success
  end

  test "should update group_contact" do
    put :update, id: @group_contact, group_contact: { active: @group_contact.active, contact_id: @group_contact.contact_id, group_id: @group_contact.group_id, position: @group_contact.position }
    assert_redirected_to group_contact_path(assigns(:group_contact))
  end

  test "should destroy group_contact" do
    assert_difference('GroupContact.count', -1) do
      delete :destroy, id: @group_contact
    end

    assert_redirected_to group_contacts_path
  end
end
