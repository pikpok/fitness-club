class PoolReservation < ActiveRecord::Base
  belongs_to :user
  validates :start_time, date: {
    after: Proc.new { DateTime.now + 15.minutes },
    message: "must be at least 15 minutes from now"
  }
  validates :end_time, date: {
    after: :start_time,
    message: "must be after start time"
  }
  validates :start_time, :end_time, overlap: true

end
