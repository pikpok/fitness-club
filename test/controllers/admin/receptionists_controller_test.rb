require 'test_helper'

class Admin::ReceptionistsControllerTest < ActionController::TestCase

  setup do
    sign_in admins(:one)
    @receptionist = receptionists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new receptionist page" do
    get :new
    assert_response :success
  end

  test "should get edit receptionist page" do
    get :edit, id: @receptionist.id
    assert_response :success
  end

  test "should add new receptionist" do
    assert_difference('Receptionist.count', +1) do
      post :create, receptionist: {
        email: "test@test.test",
        password: "testowehaslo",
        password_confirmation: "testowehaslo"
      }
    end
    assert_redirected_to admin_receptionists_path, notice: "receptionist created"
  end

  test "should edit existing receptionist" do
    patch :update, id: @receptionist.id, receptionist: {
      email: "test@test.test",
      password: "testowehaslo",
      password_confirmation: "testowehaslo"
    }
    assert_redirected_to admin_receptionists_path, notice: "receptionist updated."
  end

  test "should destroy receptionist" do
    assert_difference('Receptionist.count', -1) do
      delete :destroy, id: @receptionist.id
    end
    assert_redirected_to admin_receptionists_path, notice: "receptionist deleted."
  end
end
