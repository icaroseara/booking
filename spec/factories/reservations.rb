FactoryGirl.define do
  factory :reservation do
    booked_at Date.current.midday
    user { create(:user) }
    status :booked
  end
end
