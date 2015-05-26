require 'test_helper'

class Users::ReservationControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
  end

  test "should get reservations" do
    get :index
    assert_response :success
  end

  test "should not get reservations when not signed in" do
    sign_out users(:one)
    get :index
    assert_response :redirect
  end
end
