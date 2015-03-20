class ReservationsController < ApplicationController
  before_action :authenticate_user!
    
  def index
    @all_slots = Reservation.all_slots
    @slots_booked = Reservation.slots_booked
  end

  def create
    respond_to do |format|
      @service = Services::Reservations::CreateService.new(reservation_params.merge(user_id: current_user.id))
      if @service.is_valid?
        format.json { render json: @service.call.as_json(include: :user) } 
      else
        format.json { render json: @service.errors } 
      end
    end
  end
  
  def cancel_booking
  end
  
  private
  def reservation_params
    params.require(:reservation).permit(:booked_at)
  end
end
