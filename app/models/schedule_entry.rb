class ScheduleEntry < ActiveRecord::Base
  validates :start_time, presence: true 
  validates :end_time, presence: true
  validates :start_time, :end_time, overlap: { scope: "weekday" }
  validates :weekday, presence: true
end
