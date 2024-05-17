require 'spec_helper'

include ImageHelper

describe 'Sliders' do
  let(:user) { create(:user, status: 'paid') }

  before do
    login_as(user, scope: :user)
  end

  describe 'create new slider' do
    it 'redirects to slider edit page' do
      visit dashboard_sliders_path

      click_link 'New Slider'

      expect(page).to have_content('Get started by adding a new slide.')
    end
  end

  describe 'create new Slide' do
    let!(:slider) { create(:slider, user: user) }

    it 'saves the slide' do
      visit dashboard_edit_slider_path(short_code: slider.short_code)
      click_link 'New Slide'
      attach_file('slide_image', test_image_path)
      click_button 'Save Slide'

      expect(page).to have_content('Slide created.')
      expect(page).to have_button('Install Slider')
    end
  end

  describe 'edit Slide' do
    let!(:slider) { create(:slider, user: user) }
    let!(:slide) { create(:slide, slider: slider) }

    it 'updates the slide' do
      visit dashboard_edit_slider_path(short_code: slider.short_code)
      # click_link 'New Slide'
      # attach_file('slide_image', test_image_path)
      # click_button 'Save Slide'
      click_link 'Edit Slide'

      fill_in 'slide_url', with: 'https://google.com'
      click_button 'Save Slide'

      expect(page).to have_content('Slide updated.')
      expect(page).to have_button('Install Slider')
    end
  end
end
