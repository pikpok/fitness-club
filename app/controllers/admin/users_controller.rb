class Admin::UsersController < ApplicationController
  # make sure this class is avaiable only for Admin
  before_filter :authenticate_admin!

  # define quick filters using has_scope gem
  has_scope :first_name
  has_scope :last_name
  has_scope :email

  # List first 100 users with defined filters (none by default)
  # GET /admin/users/
  def index
    @users = apply_scopes(User).all.limit 100
  end
  
  # Renders page for creating new User
  # GET /admin/users/new
  def new
    @user = User.new
  end
  
  # Creates new User, redirects back to new User page if finds errors
  # POST /admin/users
  def create
    @user = User.new(secure_params)
    if @user.save
      redirect_to admin_users_path, notice: "User created"
    else
      redirect_to new_admin_user_path, alert: @user.errors.full_messages.to_sentence
    end
  end
  
  # Renders page editing User with provided id
  # GET /admin/users/{id}/edit
  def edit
    @user = User.find(params[:id])
  end
  
  # Edits user, if no password is defined then don't change it to null
  # Redirects to edit User path if errors are found
  # PATCH /admin/users/{id}
  def update
    @user = User.find(params[:id])
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update_attributes(secure_params)
      redirect_to admin_users_path, notice: "User updated."
    else
      redirect_to edit_admin_user_path(id: @user.id), alert: @user.errors.full_messages.to_sentence
    end
  end

  # Removes User with provided id
  # DELETE /admin/users/{id}
  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path, notice: "User deleted."
  end
  
  private

  # define allowed parameters for User
  def secure_params
    params.require(:user).permit(:first_name, :last_name, :email, :telephone, :subscription, :password, :password_confirmation)
  end
end
