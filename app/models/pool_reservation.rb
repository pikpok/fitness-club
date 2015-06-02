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
  validate :dates_must_be_in_the_same_day


  def dates_must_be_in_the_same_day
    if start_time.present? && end_time.present? && start_time.to_date != end_time.to_date
      errors.add :start_time, "has to be in the same day as end time"
    end
  end
end
