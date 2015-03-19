require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryGirl.create(:user) }
  
  # ActiveModel validations
  it { expect(validate_presence_of(:name))}
  it { expect(validate_presence_of(:email))}
  it { expect(validate_presence_of(:password))}
  it { expect(validate_uniqueness_of(:email))}  
  
  # ActiveRecord validations
  it { expect(have_many(:reservations))}  
end
