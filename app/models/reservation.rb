class Reservation < ActiveRecord::Base
  belongs_to :user
  
  enum status: [ :booked, :canceled ]
  
  validates :status, presence: true, inclusion: { in: Reservation.statuses }
  validates :booked_at, presence: true
  validate :booked_at_must_be_in_current_week, :booked_at_must_be_in_valid_time, on: :create
  
  scope :booked, -> { where(status: 0)}
  scope :in_current_week, -> { where(booked_at: Date.current.all_week)}
  scope :booked_at, -> booked_at { where(booked_at: booked_at) }
  
  START_TIME = 6
  END_TIME = 23
  
  class << self
    def all_slots
      (Time.zone.now.beginning_of_week.to_i..Time.zone.now.at_end_of_week.to_i ).step(1.hour)
                                                                              .select{|t| Time.zone.at(t).to_datetime.hour.between?(START_TIME, END_TIME)}
                                                                              .map{ |t| Time.zone.at(t).to_datetime }
                                                                              .group_by{ |t| I18n.l(t, format: :short) }
    end
  
    def slots_booked
      Hash[*Reservation.in_current_week.booked.map{ |r| [r.booked_at.to_datetime.to_s, r] }.flatten]
    end
  end
  
  private
  def booked_at_must_be_in_current_week
    errors.add(:booked_at, :invalid) unless Date.current.all_week.include?(booked_at.to_date)
  end
  
  def booked_at_must_be_in_valid_time
    errors.add(:booked_at, :invalid) unless booked_at.hour.between?(START_TIME,END_TIME)
  end
end
