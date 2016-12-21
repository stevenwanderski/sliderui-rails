require 'spec_helper'
include UnauthenticatedSliderHelper

describe 'Unauthenticated Slider Flow', js: true do
  before :each do
    create_temp_slider
  end

  describe 'Unconfirmed user' do
    it 'redirects to login when attempting to access user section' do
      visit '/app/sliders'
      expect(page).to have_content('Login')
    end
  end
end
