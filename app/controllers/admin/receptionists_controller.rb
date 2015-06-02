class Admin::ReceptionistsController < ApplicationController
  # make sure that admin is always signed in before accessing ReceptionistsController
  before_filter :authenticate_admin!

  # List all Receptionists
  # GET /admin/receptionists
  def index
    @receptionists = Receptionist.all
  end

  # Renders page for creating new Receptionist
  # GET /admin/receptionists/new
  def new
    @receptionist = Receptionist.new
  end
  
  # Creates new Receptionist, redirects to new Receptionist page if errors are found
  # POST /admin/receptionists/create
  def create
    @receptionist = Receptionist.new(secure_params)
    if @receptionist.save
      redirect_to admin_receptionists_path, notice: "Receptionist created"
    else
      redirect_to new_admin_receptionist_path, alert: @receptionist.errors.full_messages.to_sentence
    end
  end

  # Renders page for editing Receptionist
  # GET /admin/receptionists/{id}/edit
  def edit
    @receptionist = Receptionist.find(params[:id])
  end
  
  # Updates Receptionist with provided id
  # PATCH /admin/receptionists/{id}
  def update
    @receptionist = Receptionist.find(params[:id])
    if @receptionist.update_attributes(secure_params)
      redirect_to admin_receptionists_path, notice: "Receptionist updated"
    else
      redirect_to edit_admin_receptionist_path(id: @receptionist.id), alert: @receptionist.errors.full_messages.to_sentence
    end
  end
  
  # Removes Receptionist with provided id
  # DELETE /admin/receptionists/{id}
  def destroy
    receptionist = Receptionist.find(params[:id])
    receptionist.destroy
    redirect_to admin_receptionists_path, notice: "Receptionist removed"
  end

  private

  # Define parameters required for Admin to change password to disallow change of any other parameter
  def secure_params
    params.require(:receptionist).permit(:email, :password, :password_confirmation)
  end
end
