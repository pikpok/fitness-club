require 'test_helper'

class Admin::DashboardControllerTest < ActionController::TestCase
  setup do
    @admin = admins(:one)
    sign_in @admin
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should change email" do
    patch :update, admin: {
      email: "admin@admin.admin",
      current_password: "admin"
    }
    assert_redirected_to admin_root_path
    assert_equal "Your data has been updated", flash[:notice]
  end

  test "should not change admin with invalid data" do
    patch :update, admin: {
      email: "admin@admin.admin",
      password: "testtest",
      password_confirmation: "testtest1",
      current_password: "admin"
    }
    assert_redirected_to admin_edit_path
    assert_equal "Password confirmation doesn't match Password", flash[:alert]
  end
end
