class Admin::DashboardController < ApplicationController
  before_filter :authenticate_admin!

  def index
  end

  def edit
  end

  def update
    @admin = current_admin
    if @admin.update_with_password(secure_params)
      sign_in(@admin, :bypass => true)
      redirect_to admin_root_path, notice: "Your data has been updated"
    else
      redirect_to admin_root_path, alert: @admin.errors.full_messages.to_sentence
    end
  end

  private
    def secure_params
      params.require(:admin).permit(:email, :password, :current_password)
    end
end