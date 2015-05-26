class PoolReservation < ActiveRecord::Base
  belongs_to :user
  validates :start_time, date: {
    after: Proc.new { DateTime.now + 15.minutes },
    message: "is wrong"
  }
  validates :end_time, date: {
    after: :start_time,
    message: "is wrong"
  }
  validates :start_time, :end_time, overlap: true

end
