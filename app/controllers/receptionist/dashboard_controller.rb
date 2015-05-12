class Receptionist::DashboardController < ApplicationController
  before_filter :authenticate_receptionist!
  
  has_scope :first_name
  has_scope :last_name
  has_scope :email

  #def index
  #  @users = User.search(params[:first_name], params[:last_name], params[:telephone])
  #end
  
  def index
    @users = apply_scopes(User).all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to receptionist_dashboard_index, notice: "User updated."
    else
      redirect_to receptionist_dashboard_index, alert: "User cannot be updated."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to receptionist_dashboard_index, notice: "User deleted."
  end
end
