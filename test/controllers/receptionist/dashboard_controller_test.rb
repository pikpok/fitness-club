require 'test_helper'

class Receptionist::DashboardControllerTest < ActionController::TestCase
  

  test "should not get index while not signed in" do
    get :index
    assert_response :redirect
  end

  test "should get index while signed in" do
    sign_in receptionists(:one) 
    get :index
    assert_response :success
  end

end
