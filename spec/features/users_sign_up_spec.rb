require 'rails_helper'

feature 'User signs up', type: :feature do
  background { visit root_path }

  scenario 'successfully' do
    password = Faker::Internet.password 
    click_link 'Register'
    fill_in 'Name', with: Faker::Name.name
    fill_in 'Email', with: Faker::Internet.email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password
    click_button 'Sign up'

    expect(current_path).to eql '/reservations'
    expect(page).to have_content 'Booking App - Reservations'
  end

  scenario 'unsuccessfully due to required fields being blank' do
    click_link 'Register'
    click_button "Sign up"

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"
  end
end