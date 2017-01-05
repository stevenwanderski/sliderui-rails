require 'spec_helper'
include UnauthenticatedSliderHelper
include ImageHelper

describe 'Unauthenticated Slider Flow', js: true do
  it 'saves a slider, shows the tour, saves slides and settings, and provides the embed code' do
    # New slider page: creates the new slider
    visit '/temp/slider/new'
    find('[name="title"]').set('Puff Tentacle')
    click_button 'Create Slider and Add Slides'
    expect(page).to have_content('Welcome to the slider page')
    expect(Slider.count).to eq(1)

    # Slides page: displays tour
    click_button 'Start Tour!'
    expect(page).to have_content('1. Add slides')
    find('.react-user-tour-next-button').click
    find('.react-user-tour-next-button').click
    find('.react-user-tour-done-button').click

    # Slides page: adds slides
    click_button 'Add Slide'
    expect(page).to have_content('Select Image')
    expect(Slide.count).to eq(1)
    slide = Slide.first
    Capybara.ignore_hidden_elements = false
    attach_file("slide-image-#{slide.id}", test_image_path)
    Capybara.ignore_hidden_elements = true
    expect(page).to have_selector('.slide-item__control--edit')
    expect(slide.reload.image.url).to be_present

    # Settings page: shows slider preview
    click_link 'Settings'
    expect(page).to have_content('Save Settings')

    # Settings page: saves settings
    find('input[name="speed"]').set(175)
    click_button 'Save Settings'
    # The button displays "Loading..." while saving
    # so wait for it to return to "Save Settings".
    expect(page).to have_content('Save Settings')

    # Settings page: does not show tour again
    click_link 'Slides'
    expect(page).to have_content('Add Slide')
    expect(page).to_not have_css('.modal__content')

    # Embed code page: displays embed code
    click_link 'Embed Slider'
    expect(page).to have_content('Embed Slider')

    # Embed code page: saves email / password and redirects to sliders page
    find('input[name="email"]').set('frank@zappa.com')
    find('input[name="password"]').set('testtest')
    click_button 'Submit'
    expect(page).to have_content('My Sliders')
  end
end
