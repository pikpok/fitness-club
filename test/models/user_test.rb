require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  @user = User.new(email: "fooo@bb.ar", first_name: "Foo", last_name: "Barr", password: "foobar1234", subscription: Date.tomorrow)

  test "should save valid user" do
    user = User.new(email: "fooo@bb.ar", first_name: "Foo", last_name: "Barr", password: "foobar1234", subscription: Date.tomorrow)
    assert user.save
  end

  test "should not save user without email" do
    user = User.new(first_name: "Foo", last_name: "Barr", password: "foobar1234", subscription: Date.tomorrow)
    assert_not user.save
  end

  test "should not save user with invalid email" do
    user = User.new(email: "test", first_name: "Foo", last_name: "Barr", password: "foobar1234", subscription: Date.tomorrow)
    assert_not user.save
    user.email = "test@test"
    assert_not user.save
  end

  test "should not save user without password" do
    user = User.new(email: "fooo@bb.ar", first_name: "Foo", last_name: "Barr", subscription: Date.tomorrow)
    assert_not user.save
  end

  test "should not save user without first_name" do
    user = User.new(email: "fooo@bb.ar", last_name: "Barr", password: "foobar1234", subscription: Date.tomorrow)
    assert_not user.save
  end

  test "should not save user without last_name" do
    user = User.new(email: "fooo@bb.ar", first_name: "Foo", password: "foobar1234", subscription: Date.tomorrow)
    assert_not user.save
  end

  test "should not save user with invalid subscription" do
    user = User.new(email: "fooo@bb.ar", first_name: "Foo", last_name: "Barr", password: "foobar1234")
    assert_not user.save
    user.subscription = Date.new(2014, 10, 12) # date past software creation date
    assert_not user.save
  end

  test "should return if subscription is active" do
    user = User.new(email: "fooo@bb.ar", first_name: "Foo", last_name: "Barr", password: "foobar1234", subscription: Date.tomorrow)
    assert user.is_subscription_active?
    user.subscription = Date.yesterday
    assert_not user.is_subscription_active?
  end

  test "should return valid number of days for subscription to end" do
    user = User.new(email: "fooo@bb.ar", first_name: "Foo", last_name: "Barr", password: "foobar1234", subscription: Date.tomorrow + 5.days)
    assert_equal 6, user.subscription_days_left
  end
end