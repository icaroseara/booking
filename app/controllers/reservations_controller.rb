class ReservationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @reservations = Reservation.where(booked_at: Date.today.all_week)
  end
  
  def booking
  end
  
  def cancel_booking
  end
end
