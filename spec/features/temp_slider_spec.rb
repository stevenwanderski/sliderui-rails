require 'spec_helper'

describe 'Temp Slider Flow' do
  it 'creates a new slider', js: true do
    visit '/temp/slider/new'
    fill_in 'slider-name', with: 'Puff Tentacle'
    click_button 'Create Slider and Add Slides'

    expect(page).to have_content('Save and Get Code')
    expect(Slider.count).to eq(1)
    expect(Slider.first.title).to eq('Puff Tentacle')

    click_button 'Add Slide'
    expect(page).to have_content('Select Image')
    expect(Slide.count).to eq(1)
    attach_file('input[type="file"]', File.join(Rails.root, 'spec', 'support', 'images', 'dags.jpg'))
    expect(page).to have_content('edit')
  end


end
