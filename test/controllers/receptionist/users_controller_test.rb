require 'test_helper'

class Receptionist::UsersControllerTest < ActionController::TestCase
  setup do
    sign_in receptionists(:one)
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert assigns(:users)
  end

  test "should get new user page" do
    get :new
    assert_response :success
    assert assigns(:user)
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
        telephone: "111222333",
        subscription: "2015-10-20",
        password: "testowehaslo",
        password_confirmation: "testowehaslo"
      }
    end
    assert_redirected_to receptionist_users_path
    assert_equal "User created", flash[:notice]
  end

  test "should not add wrong new user" do
    assert_no_difference('User.count') do
      post :create, user: {
        first_name: "Test",
        last_name: "Testowy",
        email: "test@test.test",
        telephone: "111222333",
        subscription: "2015-10-20",
        password: "testowehaslo",
        password_confirmation: "innetestowehaslo" # password_confirmation differ from password
      }
    end
    assert_redirected_to new_receptionist_user_path
    assert_not_equal "User created", flash[:notice]
  end

  test "should edit existing user" do
    patch :update, id: @user.id, user: {
      first_name: "Test",
      last_name: "Testowy",
      email: "test@test.test",
      telephone: "111222333",
      subscription: "2015-10-20"
    }
    assert_redirected_to receptionist_users_path
    assert_equal "User updated.", flash[:notice]
  end

  test "should not edit wrong existing user" do
    patch :update, id: @user.id, user: {
      first_name: "Test",
      last_name: "Testowy",
      email: "test@test.test",
      telephone: "1112222333", # wrong number
      subscription: "2015-10-20"
    }
    assert_redirected_to edit_receptionist_user_path(id: @user.id)
    assert_not_equal "User updated.", flash[:notice]
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user.id
    end
    assert_redirected_to receptionist_users_path
    assert_equal "User deleted.", flash[:notice]
  end

end