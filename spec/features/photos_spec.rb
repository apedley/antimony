require 'spec_helper'

feature 'Photo management' do
  background do
    user = create(:user)
    @user = user
    sign_in(user)
    photo = create(:photo, user: user, title: 'Test title')
    private_photo = create(:photo, user: user, title: 'Test title', public: false)
  end
  # TODO: File upload tests 
  # scenario 'add a photo' do
  #   click_link 'New Photo'
  #   fill_in 'Title', with: 'Test title'
  # end

  scenario 'view own photos' do
    click_link 'My Photos'
    expect(page).to have_content 'New Photo'
    expect(page).to have_content 'Edit Photos'
    save_and_open_page

    expect(page).to have_selector 'a.thumbnail', :count => 2

  end



end

# TODO: Capybara + webkit + jQuery??
# feature 'Photo viewing' do
#   scenario 'some js thing', :js => true do
#     user = build(:user, password: 'sporky123', password_confirmation: 'sporky123')
#     visit root_path
#     click_link 'Sign Up'
#     fill_in 'Username', with: user.username
#     fill_in 'Email', with: user.email

#     fill_in 'Password', with: 'sporky123'
#     fill_in 'Password confirmation', with: 'sporky123'

#     click_button 'Sign up'
#     click_link 'Manage'
#     click_link 'New Photo'

#     fill_in 'Title', with: 'js img'
#     image_path = "#{Rails.root}/spec/files/test.png"
#     attach_file('photo_image', image_path)
#     click_button 'Upload'
#     # find(:css, 'a.thumbnail').click
#     # link_id = "photoLink1"

#     click_link("photoLink1")
    

#     page.save_screenshot('ss.png')

#   end
#end