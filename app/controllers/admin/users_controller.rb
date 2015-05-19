class Admin::UsersController < ApplicationController
  before_filter :authenticate_admin!

  has_scope :first_name
  has_scope :last_name
  has_scope :email

  def index
    @users = apply_scopes(User).all.limit 100
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(secure_params)
    @user.subscription = Date.tomorrow
    if @user.save
      redirect_to admin_users_path, notice: "User created"
    else
      redirect_to new_admin_user_path, alert: "#{@user.errors.full_messages}"
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to admin_users_path, notice: "User updated."
    else
      redirect_to admin_users_path, alert: "User cannot be updated - #{@user.errors.full_messages}"
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path, notice: "User deleted."
  end
  
  private
    def secure_params
      params.require(:user).permit(:first_name, :last_name, :email, :subscription, :password, :password_confirmation)
    end
end
