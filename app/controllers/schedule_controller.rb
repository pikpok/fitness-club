class ScheduleController < ApplicationController
  before_filter :authenticate_admin!, only: [:create, :update, :destroy]
  def index
    @schedule_entries = Array.new
    (1..7).each { |number| @schedule_entries << ScheduleEntry.where(weekday: number) }
  end

  def new
    @schedule_entry = ScheduleEntry.new
    @weekdays = [
      ['Monday', 1],
      ['Tuesday', 2],
      ['Wednesday', 3],
      ['Thursday', 4],
      ['Friday', 5],
      ['Saturday', 6],
      ['Sunday', 7]
    ]
  end

  def edit
    @schedule_entry = ScheduleEntry.find(params[:id])
  end

  def create
    @schedule_entry = ScheduleEntry.new(secure_params)
    if @schedule_entry.save
      redirect_to schedule_index_path, notice: "Schedule created"
    else
      redirect_to schedule_index_path, alert: @schedule_entry.errors.full_messages.to_sentence
    end
  end

  def update
    @schedule_entry = ScheduleEntry.find(params[:id])
    if @schedule_entry.update(secure_params)
      redirect_to schedule_index_path, notice: "Schedule updated"
    else
      redirect_to schedule_index_path, alert: @schedule_entry.errors.full_messages.to_sentence
    end
  end

  def destroy
    schedule_entry = ScheduleEntry.find(params[:id])
    schedule_entry.destroy
    redirect_to schedule_index_path, notice: "Schedule removed"
  end

  private
  def secure_params
    params.require(:schedule_entry).permit(:title, :trainer, :description, :weekday, :start_time, :end_time)
  end
end
