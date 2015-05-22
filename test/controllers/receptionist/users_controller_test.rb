require 'test_helper'

class Receptionist::UsersControllerTest < ActionController::TestCase
  setup do
    sign_in receptionists(:one)
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new user page" do
    get :new
    assert_response :success
  end

  test "should get edit user page" do
    get :edit, id: @user.id
    assert_response :success
  end

  test "should add new user" do
    assert_difference('User.count', +1) do
      post :create, user: {
        first_name: "Test",
        last_name: "Testowy",
        email: "test@test.test",
        subscription: Date.today + 10.days,
        password: "testowehaslo",
        password_confirmation: "testowehaslo"
      }
    end
    assert_redirected_to receptionist_users_path, notice: "User created"
  end

  test "should edit existing user" do
    patch :update, id: @user.id, user: {
      first_name: "Test",
      last_name: "Testowy",
      email: "test@test.test",
      subscription: "2015-10-20"
    }
    assert_redirected_to receptionist_users_path, notice: "User updated."
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user.id
    end
    assert_redirected_to receptionist_users_path, notice: "User deleted."
  end

end