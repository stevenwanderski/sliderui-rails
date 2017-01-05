require 'spec_helper'
include UnauthenticatedSliderHelper

describe 'Unauthenticated Slider Flow', js: true do
  before :each do
    create_temp_slider
  end

  describe 'Embed code page' do
    it 'provides the embed code' do
      slider = Slider.first
      click_button 'No, thanks.'
      click_link 'Embed Slider'
      expect(page).to have_content(slider.short_code)
    end
  end
end
