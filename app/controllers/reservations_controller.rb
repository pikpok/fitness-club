class ReservationsController < ApplicationController
  # only Receptionist and Admin can edit and remove reservations, but everyone can view them
  before_filter :authenticate_receptionist!, except: :index
  before_filter :authenticate_admin!, except: :index

  # List all Pool Reservations and add field for Admin and Receptionist to create a new one
  # GET /reservations
  def index
    @reservations = PoolReservation.all
    @reservation = PoolReservation.new
  end

  # Renders edit page for Pool Reservation with provided id
  # GET /reservations/{id}/edit
  def edit
    @reservation = PoolReservation.find(params[:id])
  end

  # Creates a new Pool Reservation for User with id. When fails, redirects to list of reservations
  # POST /reservations
  def create
    @reservation = PoolReservation.new(secure_params)
    if @reservation.save
      redirect_to reservations_path, notice: "Pool Reservation created"
    else
      redirect_to reservations_path, alert: @reservation.errors.full_messages.to_sentence
    end
  end

  # Updates Pool Reservation with specified id
  # PATCH /reservations/{id}
  def update
    @reservation = PoolReservation.find(params[:id])
    if @reservation.update(secure_params)
      redirect_to reservations_path, notice: "Pool Reservation updated"
    else
      redirect_to edit_reservation_path(id: @reservation.id), alert: @reservation.errors.full_messages.to_sentence
    end
  end

  # Removes Pool Reservation with provided id
  # DELETE /reservations/{id}
  def destroy
    @reservation = PoolReservation.find(params[:id])
    @reservation.destroy
    redirect_to reservations_path, notice: "Pool Reservation removed"
  end

  private

  # Define parameters allowed to change for Pool Reservation
  def secure_params
    params.require(:pool_reservation).permit(:start_time, :end_time, :user_id)
  end
end