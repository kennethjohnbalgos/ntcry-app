require 'test_helper'

class ImportControllerTest < ActionController::TestCase
  test "should get reader" do
    get :reader
    assert_response :success
  end

end
