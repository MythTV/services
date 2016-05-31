require 'test_helper'

class ChannelIconControllerTest < ActionController::TestCase
  test "should get ping" do
    get :ping
    assert_response :success
  end

  test "should get lookup" do
    get :lookup
    assert_response :success
  end

  test "should get check_block" do
    get :check_block
    assert_response :success
  end

  test "should get find_missing" do
    get :find_missing
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get master_iconmap" do
    get :master_iconmap
    assert_response :success
  end

  test "should post submit" do
    post :submit
    assert_response :success
  end

end
