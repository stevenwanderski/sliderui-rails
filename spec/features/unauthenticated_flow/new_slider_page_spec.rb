require 'spec_helper'
include UnauthenticatedSliderHelper
include AuthHelper

describe 'Unauthenticated Slider Flow', js: true do
  describe 'New slider page' do
    it 'creates a new slider' do
      create_temp_slider
      expect(Slider.count).to eq(1)
      expect(Slider.first.title).to eq('Puff Tentacle')
    end

    context 'user is authenticated' do
      context 'user is confirmed' do
        it 'redirects to authenticated sliders page' do
          user = create(:user, password: 'test', confirmed: true)
          login(user.email, 'test')
          visit '/temp/slider/new'
          expect(current_path).to eq('/app/sliders')
        end
      end

      context 'user is not confirmed' do
        it 'renders page' do
          create_temp_slider
          visit '/temp/slider/new'
          expect(current_path).to eq('/temp/slider/new')
        end
      end
    end

    context 'user is not authenticated' do
      it 'renders page' do
        visit '/temp/slider/new'
        expect(current_path).to eq('/temp/slider/new')
      end
    end
  end
end
