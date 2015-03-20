module Services::Reservations
  class CreateService < Services::Base    
    attr_accessor :booked_at
    attr_accessor :user_id
    
    validate :booked_at, presence: true
    validate :user_id, presence: true
    
    def call
      Reservation.create(booked_at: booked_at, status: :booked, user_id: user_id)
    end
    
    def is_valid?
      valid? && slot_available?
    end
    
    private
    
    def slot_available?
      slot_available = Reservation.in_current_week.booked.booked_at(booked_at).blank?
      errors.add(:booked_at, :invalid) unless slot_available
      slot_available
    end
  end
end