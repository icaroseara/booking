module Services::Reservations
  class UpdateService < Services::Base    
    attr_accessor :id
    attr_accessor :user_id
    attr_accessor :reservation
    
    validate :id, presence: true
    validate :user_id, presence: true
    
    def call
      reservation.update_attributes(status: :canceled)
      reservation
    end
    
    def is_valid?
      if valid?
        reservation_founded?
      else
        false
      end
    end
    
    private 
    def reservation_founded?
      @reservation = Reservation.in_current_week.booked.where(id: id, user_id: user_id).try(:take)
      errors.add(:id, :invalid) unless @reservation.blank?
      @reservation.present?
    end
  end
end