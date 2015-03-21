require "spec_helper"

feature "User logout", js: true do
  let(:user) { FactoryGirl.create(:user) }
  
  background { visit root_path }
    
  scenario 'successfully' do
    sign_in_as user
    click_link 'Logout'
    expect(current_path).to eql '/'
  end
end