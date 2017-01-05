require 'spec_helper'
include UnauthenticatedSliderHelper

describe 'Unauthenticated Slider Flow', js: true do
  describe 'Preview page' do
    context 'when slides do not exist' do
      it 'shows the empty preview' do
        create_temp_slider
        click_button 'No, thanks.'
        expect(page).to have_content('Slider will appear after adding a slide')
      end
    end
  end
end
