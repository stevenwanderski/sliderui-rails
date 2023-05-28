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

      expect(page).to have_content('Get started by adding a new image.')
    end
  end

  describe 'edit a slider' do
    let!(:slider) { create(:slider, user: user) }

    it 'saves an image' do
      visit dashboard_edit_slider_path(short_code: slider.short_code)

      attach_file('file-upload', test_image_path)

      expect(page).to have_content('Image saved!')
      expect(page).to have_button('Install Slider')
    end
  end
end
