class Users::ReservationController < ApplicationController
  before_filter :authenticate_user!

  # List all User's Pool Reservations and allow User to create new reservation
  # GET /users/reservation/index
  def index
    @reservations = current_user.pool_reservations.all
    @reservation = current_user.pool_reservations.new
  end

  # Creates a new Pool Reservation assigned to currently logged in User
  # POST /users/reservation
  def create
    @reservation = current_user.pool_reservations.new(secure_params)
    if @reservation.save
      redirect_to users_reservation_index_path, notice: "Pool reserved"
    else
      redirect_to users_reservation_index_path, alert: @reservation.errors.full_messages.to_sentence
    end
  end

  # Removes User's Pool Reservation with specific id
  # DELETE /users/reservation/{id}
  def destroy
    @reservation = current_user.pool_reservations.find(params[:id])
    @reservation.destroy
    redirect_to users_reservation_index_path, notice: "Reservation removed"
  end

  private
  # Define parameters allowed for Pool Reservation
  def secure_params
    params.require(:pool_reservation).permit(:start_time, :end_time)
  end
end
