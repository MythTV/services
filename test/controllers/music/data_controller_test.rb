require 'test_helper'

class Music::DataControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :redirect
  end
  test "should get stream data" do
    get :index,
      params: { data: "streams" }
    assert_redirected_to "http://ftp.osuosl.org/pub/mythtv/music/db/streams.gz"
  end
end
