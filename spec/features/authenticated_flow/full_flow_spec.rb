require 'spec_helper'
include UnauthenticatedSliderHelper
include ImageHelper

describe 'Authenticated Slider Flow', js: true do
  it 'saves a slider, does not show the tour, saves slides and settings, and provides the embed code' do
    user = create(:user, email: 'frank@zappa.com', password: 'testtest')
    slider = create(:slider, user: user)
    slide = create(:slide, slider: slider)

    # Login
    visit '/auth'
    find('input[name="email"]').set('frank@zappa.com')
    find('input[name="password"]').set('testtest')
    find('button').click
    expect(page).to have_content('frank@zappa.com')
    expect(page).to have_content('My Sliders')

    # New slider page: creates the new slider
    click_link '+ Add New Slider'
    find('[name="title"]').set('Puff Tentacle')
    click_button 'Create Slider and Add Slides'
    expect(page).to have_content('Add Slide')

    # Slides page: does not display tour
    expect(page).to_not have_css('.modal__content')

    # Settings page: adds slides
    click_button 'Add Slide'
    expect(page).to have_content('Select Image')
    slide = Slide.order(created_at: :desc).first
    Capybara.ignore_hidden_elements = false
    attach_file("slide-image-#{slide.id}", test_image_path)
    Capybara.ignore_hidden_elements = true
    expect(page).to have_selector('.slide-item__control--edit')
    expect(slide.reload.image.url).to be_present

    # Settings page: shows slider preview
    click_link 'Settings & Preview'
    expect(page).to have_css('.slider-preview')

    # Settings page: saves settings
    find('input[name="speed"]').set(175)
    click_button 'Save Settings'
    # The button displays "Loading..." while saving
    # so wait for it to return to "Save Settings".
    expect(page).to have_content('Save Settings')

    # Embed code page: displays embed code
    click_link 'Embed Code'
    expect(page).to have_content('Embed Code')
  end
end
