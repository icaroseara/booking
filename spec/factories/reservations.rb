FactoryGirl.define do
  factory :reservation do
    booked_at Time.now
    user { create(:user) }
    status :booked
  end
end
