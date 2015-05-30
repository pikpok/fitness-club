require 'test_helper'

class Users::ReservationControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    post :create, pool_reservation: {
      start_time: DateTime.now + 100.minutes,
      end_time: DateTime.now + 150.minutes
    }
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

  test "should create new reservation" do
    assert_difference("PoolReservation.count", +1) do
      post :create, pool_reservation: {
        start_time: DateTime.now + 20.minutes,
        end_time: DateTime.now + 50.minutes
      }
    end
    assert_redirected_to users_reservation_index_path
    assert_equal "Pool reserved", flash[:notice]
  end

  test "should not create invalid reservation" do
    assert_no_difference("PoolReservation.count") do
      post :create, pool_reservation: {
        start_time: DateTime.now + 10.minutes,
        end_time: DateTime.now - 20.minutes
      }
    end
    assert_redirected_to users_reservation_index_path
    assert_equal "Start time must be at least 15 minutes from now and End time must be after start time", flash[:alert]
  end

  test "should delete reservation" do
    assert_difference("PoolReservation.count", -1) do
      delete :destroy, id: users(:one).pool_reservations.first.id
    end
    assert_redirected_to users_reservation_index_path
    assert_equal "Reservation removed", flash[:notice]
  end
end
