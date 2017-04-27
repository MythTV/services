require 'test_helper'

class RootControllerTest < ActionController::TestCase
  test "index should succeed" do
    get :index
    assert_response :success
  end

end
