require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.new(
      email: "fooo@bb.ar",
      first_name: "Foo",
      last_name: "Barr",
      telephone: '111222333',
      password: "foobar1234",
      subscription: Date.tomorrow)
  end

  test "should save valid user" do
    assert @user.save
  end

  test "should not save user without email" do
    @user.email = nil
    assert_not @user.save
  end

  test "should not save user with invalid email" do
    @user.email = "test"
    assert_not @user.save
    @user.email = "test@test"
    assert_not @user.save
  end

  test "should not save user without password" do
    @user.password = nil
    assert_not @user.save
  end

  test "should not save user without first_name" do
    @user.first_name = nil
    assert_not @user.save
  end

  test "should not save user without last_name" do
    @user.last_name = nil
    assert_not @user.save
  end

  test "should not save user with invalid subscription" do
    @user.subscription = nil
    assert_not @user.save
    @user.subscription = Date.new(2014, 10, 12) # date past software creation date
    assert_not @user.save
  end

  test "should return if subscription is active" do
    assert @user.is_subscription_active?
    @user.subscription = Date.yesterday
    assert_not @user.is_subscription_active?
  end

  test "should return valid number of days for subscription to end" do
    @user.subscription += 5.days
    assert_equal 6, @user.subscription_days_left
  end
end