require 'spec_helper'

describe 'New Slider' do
  it 'shows the link', js: true do
    visit '/temp/new'
    fill_in 'slider-name', with: 'Puff Tentacle'
    click_button 'Create Slider and Add Slides'

    expect(page).to have_content('Add Slide')
  end
end
