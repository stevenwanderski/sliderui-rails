require 'spec_helper'
include UnauthenticatedSliderHelper

describe 'Unauthenticated Slider Flow', js: true do
  before :each do
    create_temp_slider
  end

  describe 'Preview page' do
    context 'when slides exist' do
      it 'shows the slider preview' do
        slider = Slider.first
        slide = create(:slide, slider: slider)
        click_button 'No, thanks.'
        click_link 'Preview'
        expect(page).to have_css('.slider-preview')
      end
    end

    context 'when slides do not exist' do
      it 'shows the empty preview' do
        click_button 'No, thanks.'
        click_link 'Preview'
        expect(page).to have_content('Slider will appear after adding a slide')
      end
    end
  end
end
