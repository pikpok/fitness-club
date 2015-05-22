require 'test_helper'

class Receptionist::DashboardControllerTest < ActionController::TestCase
  setup do
    sign_in receptionists(:one)
  end

  test "should not get index while not signed in" do
    sign_out receptionists(:one)
    get :index
    assert_response :redirect
  end

  test "should get index while signed in" do
    get :index
    assert_response :success
  end

  test "should get edit page" do
    get :edit
    assert_response :success
  end


  # test "should change password" do
  #   sign_in receptionists(:one)
  #   assert_difference('receptionists(:one).encrypted_password') do
  #     patch :update, receptionist: {
  #       email: receptionists(:one).email,
  #       password: "testpassword",
  #       password_confirmation: "testpassword",
  #       current_password: "receptionist"
  #     }
  #   end
  #   assert_redirected_to :index
  # end

end
