require 'test_helper'

class PoolReservationTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @reservation = @user.pool_reservations.new(
      start_time: DateTime.now + 30.minutes,
      end_time: DateTime.now + 60.minutes)
  end

  test "should create valid pool reservation" do
    assert @reservation.save
  end

  test "should not create reservation when end_time is before start_time" do
    @reservation.end_time = DateTime.now - 30.minutes
    assert_not @reservation.save
  end

  test "should not create reservation when it would overlap another reservation" do
    another_reservation = @user.pool_reservations.new(
      start_time: DateTime.now + 40.minutes,
      end_time: DateTime.now + 50.minutes)
    assert @reservation.save
    assert_not another_reservation.save
  end

  test "should not create reservation is start_time is before 15 minutes from now" do
    @reservation.start_time = DateTime.now + 5.minutes
    assert_not @reservation.save
  end
end
