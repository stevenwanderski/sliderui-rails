require 'spec_helper'
include AuthHelper
include ImageHelper

describe 'Authenticated Slider Flow', js: true do
  before :each do
    @user = create(:user, email: 'frank@zappa.com', password: 'testtest')
    @slider = create(:slider, user: @user)
    login('frank@zappa.com', 'testtest')
  end

  describe 'Slider settings page' do
    it 'correctly saves and displays checkbox settings' do
      click_link @slider.title
      expect(page).to have_content('Add Slide')

      click_link 'Settings'
      click_button 'Save Settings'
      # The button displays "Loading..." while saving
      # so wait for it to return to "Save Settings".
      expect(page).to have_content('Save Settings')
      expect(@slider.reload.settings['pager']).to eq(true)

      find('input[name="pager"]').set(false)
      click_button 'Save Settings'
      # The button displays "Loading..." while saving
      # so wait for it to return to "Save Settings".
      expect(page).to have_content('Save Settings')
      expect(@slider.reload.settings['pager']).to eq(false)

      click_link 'Slides'
      expect(page).to have_content('Add Slide')

      click_link 'Settings'
      expect(page).to have_content('Save Settings')
      expect(find('input[name="pager"]')).to_not be_checked
    end

    it 'refreshes the preview after adding a slide' do
      click_link @slider.title
      expect(page).to have_content('Add Slide')

      # Select an image
      Capybara.ignore_hidden_elements = false
      attach_file("slide-image-new", test_image_path)
      Capybara.ignore_hidden_elements = true

      expect(page).to have_content('Updating preview...')
    end

    it 'refreshes the preview after updating a slide' do
      slide = create(:slide, slider: @slider)
      click_link @slider.title
      expect(page).to have_content('Add Slide')
      first('.slide-item__control--edit').click

      # Select an image
      Capybara.ignore_hidden_elements = false
      attach_file("slide-image-#{slide.id}", test_image_path)
      Capybara.ignore_hidden_elements = true

      expect(page).to have_content('Updating preview...')
    end

    it 'refreshes the preview after deleting a slide' do
      slide = create(:slide, slider: @slider)
      click_link @slider.title
      expect(page).to have_content('Add Slide')
      first('.slide-item__control--edit').click

      click_link 'Delete'
      expect(page).to have_content('Updating preview...')
    end
  end
end
