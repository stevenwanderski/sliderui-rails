module UnauthenticatedSliderHelper
  def create_temp_slider
    visit '/temp/slider/new'
    find('[name="title"]').set('Puff Tentacle')
    click_button 'Create Slider and Add Slides'
    expect(page).to have_content('Welcome to the slider page')
  end
end
