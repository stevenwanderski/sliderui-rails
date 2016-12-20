require 'spec_helper'
include TempSliderHelper

describe 'Temp Slider Flow', js: true do
  before :each do
    create_temp_slider
  end

  describe 'Settings page' do
    it 'shows the tour only once' do
      click_button 'Start Tour!'
      expect(page).to have_content('1. Add slides')

      click_link 'Preview'
      # expect that the preview is rendered

      click_link 'Settings'
      # expect that the tour is not rendered
    end

    it 'saves a slide' do
      click_button 'No, thanks.'
      click_button 'Add Slide'
      expect(page).to have_content('Select Image')
      expect(Slide.count).to eq(1)

      slide = Slide.first
      Capybara.ignore_hidden_elements = false
      attach_file("slide-image-#{slide.id}", File.join(Rails.root, 'spec', 'support', 'images', 'dags.jpg'))
      Capybara.ignore_hidden_elements = true
      expect(page).to have_selector('.slide-item__control--edit')
      expect(slide.reload.image.url).to be_present
    end

    it 'saves the settings' do

    end
  end
end
