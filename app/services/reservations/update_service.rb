module Services::Reservations
  class UpdateService < Services::Base    
    attr_accessor :id
    attr_accessor :user_id
    attr_accessor :reservation
    
    validates_presence_of :id
    validates_presence_of :user_id
    
    def call
      reservation.update_attributes(status: :canceled) if reservation.present?
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