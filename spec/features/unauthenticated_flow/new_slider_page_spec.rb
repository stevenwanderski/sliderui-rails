require 'spec_helper'
include UnauthenticatedSliderHelper

describe 'Unauthenticated Slider Flow', js: true do
  before :each do
    create_temp_slider
  end

  describe 'New slider page' do
    it 'creates a new slider' do
      expect(Slider.count).to eq(1)
      expect(Slider.first.title).to eq('Puff Tentacle')
    end
  end
end
