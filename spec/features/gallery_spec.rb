require 'spec_helper'

feature 'Photo management' do
  background do
    user = create(:user)
    @user = user
    sign_in(user)

    gallery = create(:gallery, user: user, name: 'Test title')
    private_gallery= create(:gallery, user: user, name: 'Private title', public: false)
  end


  scenario 'view own public and private galleries' do
    click_link 'My Galleries'
    expect(page).to have_selector 'li.gallery_thumb', :count => 4
    expect(page).to have_content 'Test title'
    expect(page).to have_content 'Private title'

    click_link 'Galleries'
    expect(page).to_not have_content 'Private title'
    expect(page).to have_content 'Test title'
  end

  scenario 'edit a gallery' do
    click_link 'My Galleries'
    click_link 'Private title'
    click_link 'Edit'

    fill_in 'gallery_name', with: 'New Title'
    check('gallery_public')
    click_button 'Save'

    expect(page).to have_content 'New Title'

    click_link 'Galleries'
    expect(page).to have_content 'New Title'
  end
  
  scenario 'delete a gallery' do
    click_link 'My Galleries'
    click_link 'Private title'
    click_link 'Edit'
    expect { click_link('Delete Gallery') }.to change(Gallery, :count).by(-1)
  end

  # scenario 'create a gallery' do
  #   photo = create(:photo, title: 'test photo', user: @user)
  #   click_link 'New Gallery'
  #   check("cb#{photo.id}")
  #   fill_in 'Name', with: 'New Test Gallery'
  #   expect { click_button('Save') }.to change(Gallery, :count).by(1)
  #   click_link 'My Galleries'
  #   expect(page).to have_content 'New Test Gallery'
  #   click_link 'New Test Gallery'
  #   expect(page).to have_selector('a.thumbnail')
  #   expect(page).to have_xpath("//img[@src=\"#{photo.image_url}\"]")
  # end

end