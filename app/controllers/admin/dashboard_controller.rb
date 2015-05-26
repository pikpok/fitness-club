class Admin::DashboardController < ApplicationController
  # make sure that admin is always signed in before accessing dashboard
  before_filter :authenticate_admin!

  # GET /admin/
  def index
  end

  # GET /admin/edit
  def edit
  end

  # Function to update email and password of currently logged in Admin.
  # It needs current password to update.
  # If some of parameters fails to update it redirects to index with errors
  # 
  # PATCH /admin/update
  def update
    @admin = current_admin
    if @admin.update_with_password(secure_params)
      sign_in(@admin, :bypass => true) # doesn't logout Admin when succesfully changed account
      redirect_to admin_root_path, notice: "Your data has been updated"
    else
      redirect_to admin_root_path, alert: @admin.errors.full_messages.to_sentence
    end
  end

  private

  # Define parameters required for Admin to change password to disallow change of any other parameter
  def secure_params
    params.require(:admin).permit(:email, :password, :password_confirmation, :current_password)
  end
end