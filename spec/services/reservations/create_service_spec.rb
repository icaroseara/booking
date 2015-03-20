require 'rails_helper'

RSpec.describe Services::Reservations::CreateService do
  let(:booking_time) { Date.current.midday }
  let(:user) { FactoryGirl.create(:user) }
  let(:reservation) { FactoryGirl.create(:reservation, booked_at: booking_time ) }
  
  describe "#valid?" do
    it "with required params" do
      service = Services::Reservations::CreateService.new(booked_at: booking_time, user_id: user.id)
      expect(service.is_valid?).to be_truthy
    end
    
    it "without user_id" do
      service = Services::Reservations::CreateService.new(booked_at: booking_time)
      expect(service.is_valid?).to be_falsey
    end
    
    it "without booked_at" do
      service = Services::Reservations::CreateService.new(user_id: user.id)
      expect(service.is_valid?).to be_falsey
    end
    
    it "with invalid booked_at" do
      service = Services::Reservations::CreateService.new(booked_at: Date.current.next_month)
      expect(service.is_valid?).to be_falsey
    end
  end
  
  describe "#call" do
    it "with slot available" do
      service = Services::Reservations::CreateService.new(booked_at: Date.current.midday + 1.hour, user_id: user.id)
      expect(service.is_valid?).to be_truthy
      expect(service.call).to be_truthy
    end
    
    it "with slot unavailable" do
      service = Services::Reservations::CreateService.new(booked_at: reservation.booked_at, user_id: user.id)
      expect(service.is_valid?).to be_falsey
      expect(service.call).to be_falsey
    end
  end
end
