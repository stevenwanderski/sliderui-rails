require 'spec_helper'

describe 'Sliders', js: true do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end

  it 'creates a slider' do
    visit new_dashboard_slider_path
    fill_in 'slider_title', with: 'Hot Rats'
    click_button 'Create Slider and Add Slides'

    expect(page).to have_content('Add at least one slide to make a proper slider')
  end

  it 'edits a slider' do
    slider = create(:slider, user: user)

    visit edit_dashboard_slider_path(slider)
    click_link 'Settings'
    select 'Vertical', from: 'slider_settings_mode'
    click_button 'Save Settings'

    expect(page).to have_content('Updating slider...')
  end

  it 'destroys a slider' do
    slider = create(:slider, user: user, title: 'Hot Rats')

    visit edit_dashboard_slider_path(slider)
    accept_confirm do
      click_link 'Delete'
    end

    expect(page).to have_content("Slider \"Hot Rats\" was deleted.")
  end
end
