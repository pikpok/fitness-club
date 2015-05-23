class Admin::ReceptionistsController < ApplicationController
    def index
      @receptionists = Receptionist.all
    end
  
    def show
      @receptionist = Receptionist.find(params[:id])
    end

    def new
      @receptionist = Receptionist.new
    end
  
    def create
      @receptionist = Receptionist.new(secure_params)
      if @receptionist.save
        redirect_to admin_receptionists_path, notice: "Receptionist created"
      else
        redirect_to new_admin_receptionist_path, alert: @receptionist.errors.full_messages.to_sentence
      end
    end
  
    def update
      @receptionist = Receptionist.find(params[:id])
      if @receptionist.update_attributes(secure_params)
        redirect_to admin_receptionists_path, notice: "Receptionist updated"
      else
        redirect_to edit_admin_receptionist_path(id: @receptionist.id), alert: @receptionist.errors.full_messages.to_sentence
      end
    end
  
    def edit
      @receptionist = Receptionist.find(params[:id])
    end
  
    def destroy
      receptionist = Receptionist.find(params[:id])
      receptionist.destroy
      redirect_to admin_receptionists_path, notice: "Receptionist removed"
    end

    private
      def secure_params
        params.require(:receptionist).permit(:email, :password, :password_confirmation)
      end
end
