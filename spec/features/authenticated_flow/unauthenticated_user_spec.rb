require 'spec_helper'
include AuthHelper

describe 'Authenticated Slider Flow', js: true do
  describe 'Unauthenticated user' do
    it 'redirects to login page' do
      visit '/app/sliders'
      expect(page).to have_content('Login')
    end
  end
end
