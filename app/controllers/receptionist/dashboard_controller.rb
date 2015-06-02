class Receptionist::DashboardController < ApplicationController
  # make sure receptionist is logged in before accessing this class
  before_filter :authenticate_receptionist!

  # Renders Receptionist dashboard page
  # GET /receptionist/dashboard
  def index
  end

  # Renders edit Receptionist page
  # GET /receptionist/dashboard/edit
  def edit
  end

  # Updates parameters of currently logged in Receptionist
  # Also bypasses logging out after change of parameters
  # PATCH /receptionist/dashboard/update
  def update
    @receptionist = current_receptionist
    if @receptionist.update_with_password(secure_params)
      sign_in(@receptionist, :bypass => true)
      redirect_to receptionist_root_path, notice: "Your data has been updated"
    else
      redirect_to receptionist_edit_path, alert: @receptionist.errors.full_messages.to_sentence
    end
  end

  private

  # define parameters allowed to update for Receptionist
  def secure_params
    params.require(:receptionist).permit(:email, :password, :password_confirmation, :current_password)
  end
end
