require 'spec_helper'
include AuthHelper

describe 'Unauthenticated Slider Flow', js: true do
  describe 'Authenticated user' do
    context 'New slider page' do
      it 'redirects to sliders page' do
        user = create(:user, email: 'frank@zappa.com', password: 'testtest')
        login('frank@zappa.com', 'testtest')
        visit '/temp/slider/new'
        expect(page).to have_content('My Sliders')
      end
    end

    context 'Slider settings page' do
      it 'redirects to sliders page' do
        user = create(:user, email: 'frank@zappa.com', password: 'testtest')
        slider = create(:slider, user: user)
        login('frank@zappa.com', 'testtest')
        visit "/temp/slider/#{slider.id}/edit"
        expect(page).to have_content('My Sliders')
      end
    end
  end
end
