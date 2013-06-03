require 'spec_helper'

feature 'User management' do
  background do
    user = create(:user)
    sign_in(user)
  end
  scenario "sign up for an account" do
    click_link 'Sign Out'
    visit root_path
    click_link 'Sign Up'
    fill_in 'Username', with: 'testuser'
    fill_in 'Email', with: 'test@testplace.com'
    fill_in 'Password', with: 'test123'
    fill_in 'Password confirmation', with: 'test123'

    click_button 'Sign up'
    expect(page).to have_content 'You have signed up'
  end

  scenario "visit profile" do
    click_link 'My Profile'
    expect(page).to have_content('Profile')
  end

end