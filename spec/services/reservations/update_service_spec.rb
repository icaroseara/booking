require 'rails_helper'

RSpec.describe Services::Reservations::UpdateService do
  let(:booking_time) { Date.current.midday }
  let(:user) { FactoryGirl.create(:user) }
  let(:reservation) { FactoryGirl.create(:reservation, booked_at: booking_time ) }
  
  describe "#valid?" do
    it "with required params" do
      service = Services::Reservations::UpdateService.new(user_id: reservation.user.id, id: reservation.id)
      expect(service.is_valid?).to be_truthy
    end
    
    it "without reservation_id" do
      service = Services::Reservations::UpdateService.new(user_id: user.id)
      expect(service.is_valid?).to be_falsey
    end
    
    it "without user_id" do
      service = Services::Reservations::UpdateService.new(id: reservation.id)
      expect(service.is_valid?).to be_falsey
    end
    
    it "with invalid user_id" do
      service = Services::Reservations::UpdateService.new(user_id: user.id, id: reservation.id)
      expect(service.is_valid?).to be_falsey
    end
    
    it "with invalid reservation_id" do
      service = Services::Reservations::UpdateService.new(user_id: reservation.user.id, id: reservation.id+1)
      expect(service.is_valid?).to be_falsey
    end
  end
  
  describe "#call" do
    it "with valid reservation" do
      service = Services::Reservations::UpdateService.new(user_id: reservation.user.id, id: reservation.id)
      expect(service.is_valid?).to be_truthy
      expect(service.call).to be_truthy
    end
    
    it "with invalid reservation" do
      service = Services::Reservations::UpdateService.new(user_id: reservation.user.id, id: reservation.id+1)
      expect(service.is_valid?).to be_falsey
      expect(service.call).to be_falsey
    end
  end
end
