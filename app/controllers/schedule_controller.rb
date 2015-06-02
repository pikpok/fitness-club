class ScheduleController < ApplicationController
  # make sure only Admin is allowed to change schedule and everyone can view it
  before_filter :authenticate_admin!, except: :index
  
  # Renders Schedule Entries for each weekday
  # GET /schedule
  def index
    @schedule_entries = Array.new
    (1..7).each { |number| @schedule_entries << ScheduleEntry.where(weekday: number) }
  end

  # Renders new Schedule Entry page
  # GET /schedule/new
  def new
    @schedule_entry = ScheduleEntry.new
  end

  # Renders page for editing Schedule Entry with provided id
  # GET /schedule/{id}/edit
  def edit
    @schedule_entry = ScheduleEntry.find(params[:id])
  end

  # Creates a new Schedule Entry, if errors are found then redirect to new Schedule Entry page
  # POST /schedule
  def create
    @schedule_entry = ScheduleEntry.new(secure_params)
    if @schedule_entry.save
      redirect_to schedule_index_path, notice: "Schedule created"
    else
      redirect_to new_schedule_path, alert: @schedule_entry.errors.full_messages.to_sentence
    end
  end

  # Updates Schedule Entry with provided id, when errors are found redirects to edit Schedule Entry page
  # PATCH /schedule/{id}
  def update
    @schedule_entry = ScheduleEntry.find(params[:id])
    if @schedule_entry.update(secure_params)
      redirect_to schedule_index_path, notice: "Schedule updated"
    else
      redirect_to edit_schedule_path(id: @schedule_entry.id), alert: @schedule_entry.errors.full_messages.to_sentence
    end
  end

  # Deletes Schedule Entry with provided id
  # DELETE /schedule/{id}
  def destroy
    schedule_entry = ScheduleEntry.find(params[:id])
    schedule_entry.destroy
    redirect_to schedule_index_path, notice: "Schedule removed"
  end

  private
  # Parameters that can be changed in Schedule Entry
  def secure_params
    params.require(:schedule_entry).permit(:title, :trainer, :description, :weekday, :start_time, :end_time)
  end
end
