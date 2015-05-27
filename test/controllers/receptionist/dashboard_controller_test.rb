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

  test "should change email" do
    patch :update, receptionist: {
      email: "receptionist@receptioni.st",
      current_password: "receptionist"
    }
    assert_redirected_to receptionist_root_path
    assert_equal "Your data has been updated", flash[:notice]
  end

  test "should not change receptionist with invalid data" do
    patch :update, receptionist: {
      email: "receptionist@receptioni.st",
      password: "testtest",
      password_confirmation: "testtest1",
      current_password: "receptionist"
    }
    assert_redirected_to receptionist_edit_path
    assert_equal "Password confirmation doesn't match Password", flash[:alert]
  end
end
