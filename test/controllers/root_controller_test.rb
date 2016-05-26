require 'test_helper'

class RootControllerTest < ActionController::TestCase
  test "index should redirect" do
    get :index
    assert_response :redirect
  end

end
