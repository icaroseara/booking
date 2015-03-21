require "spec_helper"

feature "User login", js: true do
  background { visit root_path }
  
  scenario 'successfully' do
    user = FactoryGirl.create(:user)
    sign_in_as user
    expect(current_path).to eql '/reservations'  
    expect(page).to have_content user.name
    expect(page).to have_content "Signed in successfully"
  end
  
  scenario 'unsuccessfully with invalid credentials' do
    another_user = User.new(email: Faker::Internet.email, password: Faker::Internet.password )
    sign_in_as another_user
    expect(page).to have_content "Invalid email or password"
  end
  
  scenario 'unsuccessfully due to required fields being blank' do
    click_link 'Login'
    click_button 'Sign in'
    expect(page).to have_content "Invalid email or password"
  end
end