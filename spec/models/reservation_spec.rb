require 'rails_helper'

RSpec.describe Reservation, type: :model do
  # ActiveModel validations
  it { expect(validate_presence_of(:booked_at))}
  it { expect(validate_presence_of(:status))}
  it { expect(validate_inclusion_of(:status).in_range(Reservation.statuses))}
  
  # ActiveRecord validations
  it { expect(belong_to(:user))}
  
  # Custom validations
  describe "booked_at must to be in current week" do
    context "when valid" do
      it { expect { FactoryGirl.create(:reservation, booked_at: Date.current.midday) }.not_to raise_error }
    end
    context "when invalid" do
      it { expect { FactoryGirl.create(:reservation, booked_at: Date.current.midday + 1.week) }.to raise_error ActiveRecord::RecordInvalid }
      it { expect { FactoryGirl.create(:reservation, booked_at: Date.current.midday - 1.week) }.to raise_error ActiveRecord::RecordInvalid }
    end
  end
  
  describe "booked_at must to be between 6:00 a.m. and 11:00 p.m." do
    context "when valid" do
      it { expect { FactoryGirl.create(:reservation, booked_at: Date.current.midday) }.not_to raise_error }
      it { expect { FactoryGirl.create(:reservation, booked_at: Date.yesterday.midday) }.not_to raise_error }
    end
    context "when invalid" do
      it { expect { FactoryGirl.create(:reservation, booked_at: Date.current.at_beginning_of_day).to raise_error ActiveRecord::RecordInvalid }}
      it { expect { FactoryGirl.create(:reservation, booked_at: Date.current.at_end_of_day).to raise_error ActiveRecord::RecordInvalid }}
    end
  end
end
