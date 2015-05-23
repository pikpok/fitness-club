class Receptionist::DashboardController < ApplicationController
  before_filter :authenticate_receptionist!

  def index
  end

  def edit
  end

  def update
    @receptionist = current_receptionist
    if @receptionist.update_with_password(secure_params)
      sign_in(@receptionist, :bypass => true)
      redirect_to receptionist_root_path, notice: "Your data has been updated"
    else
      redirect_to receptionist_root_path, alert: @receptionist.errors.full_messages.to_sentence
    end
  end

  private
    def secure_params
      params.require(:receptionist).permit(:email, :password, :current_password)
    end
end
