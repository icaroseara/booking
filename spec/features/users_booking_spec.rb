require "spec_helper"

feature "Signed in user can booking a room", js: true do
  background do
    user = FactoryGirl.create(:user)
    visit root_path
    sign_in_as user
  end
    
  scenario 'with available slot' do
    first(".create_booking").click
    expect(page).to have_css ".cancel_booking"
  end
end