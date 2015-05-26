class Users::ReservationController < ApplicationController
  before_filter :authenticate_user!

  def index
    @reservations = current_user.pool_reservations.all
    @reservation = current_user.pool_reservations.new
  end

  def edit
    @reservation = current_user.pool_reservations.find(params[:id])
  end

  def create
    @reservation = current_user.pool_reservations.new(secure_params)
    if @reservation.save
      redirect_to users_reservation_index_path, notice: "Pool reserved"
    else
      redirect_to users_reservation_index_path, alert: @reservation.errors.full_messages.to_sentence
    end
  end

  def destroy
    @reservation = current_user.pool_reservations.find(params[:id])
    @reservation.destroy
    redirect_to users_reservation_index_path, notice: "Reservation removed"
  end

  private
  def secure_params
    params.require(:pool_reservation).permit(:start_time, :end_time)
  end
end
