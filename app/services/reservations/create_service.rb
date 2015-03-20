module Services::Reservations
  class CreateService < Services::Base    
    attr_accessor :booked_at
    attr_accessor :user_id
    
    validates_presence_of :booked_at
    validates_presence_of :user_id
    
    def call
      Reservation.create(booked_at: booked_at, status: :booked, user_id: user_id) if is_valid?
    end
    
    def is_valid?
      valid? && slot_available?
    end
    
    private
    
    def slot_available?
      slot_available = Reservation.in_current_week.booked.booked_at(booked_at.to_time).blank?
      errors.add(:booked_at, :invalid) unless slot_available
      slot_available
    end
  end
end