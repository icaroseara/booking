class Reservation < ActiveRecord::Base
  belongs_to :user
  
  enum status: [ :booked, :canceled ]
  
  validates :status, presence: true, inclusion: { in: Reservation.statuses }
  validates :booked_at, presence: true
  validate :booked_at_must_be_in_current_week, :booked_at_must_be_in_valid_time, on: :create
  
  START_TIME = 6
  END_TIME = 23
  
  private
  def booked_at_must_be_in_current_week
    errors.add(:booked_at, :invalid) unless Date.today.all_week.include?(booked_at.to_date)
  end
  
  def booked_at_must_be_in_valid_time
    errors.add(:booked_at, :invalid) unless booked_at.between?(Date.today.beginning_of_day + START_TIME.hours, Date.today.beginning_of_day + END_TIME.hours)
  end
end
