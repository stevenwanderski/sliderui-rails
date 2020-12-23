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

  describe 'free plan' do
    context 'one or more sliders exist' do
      let!(:slider1) { create(:slider, user: user, title: 'Hot Rats') }
      let!(:slider2) { create(:slider, user: user, title: 'Apostrophe', restricted: true) }
      let!(:slider3) { create(:slider, user: user, title: 'Overnight Sensation', restricted: true) }

      it 'shows the lock button' do
        visit dashboard_sliders_path
        expect(page).to have_selector('.button--lock')
        expect(page).to have_link('Add New Slider', href: edit_dashboard_subscription_path)
      end

      it 'shows the restricted sliders' do
        visit dashboard_sliders_path
        expect(page).to have_content('Access to the following sliders requires the Premium plan')
      end

      it 'redirects to subscription on new slider' do
        visit new_dashboard_slider_path
        expect(page).to have_content('Current plan: Free')
      end
    end
  end
end
