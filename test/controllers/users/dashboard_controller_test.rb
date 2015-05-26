require 'test_helper'

class Users::DashboardControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
  end

  test "should not get index while not signed in" do
    sign_out users(:one)
    get :index
    assert_response :redirect
  end

  test "should get index while signed in" do
    get :index
    assert_response :success
  end
end
