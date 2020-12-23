require 'spec_helper'

describe 'Sliders Dashboard', js: true do
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

  it 'shows the embed instructions' do
    slider = create(:slider, user: user)
    visit dashboard_slider_embed_path(slider)
    expect(page).to have_content('Click here to copy code')
  end

  context 'no sliders exist' do
    it 'shows the empty message' do
      visit dashboard_sliders_path
      expect(page).to have_content('Create your first slider!')
    end
  end

  describe 'free plan' do
    context 'one or more sliders exist' do
      let!(:slider1) { create(:slider, user: user, title: 'Hot Rats') }
      let!(:slider2) { create(:slider, user: user, title: 'Apostrophe') }
      let!(:slider3) { create(:slider, user: user, title: 'Overnight Sensation') }

      before do
        user.update_to_free!
      end

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

  describe 'premium plan' do
    before do
      user.update_to_premium!('cus_123')
    end

    context 'one or more sliders exist' do
      let!(:slider1) { create(:slider, user: user, title: 'Hot Rats') }
      let!(:slider2) { create(:slider, user: user, title: 'Apostrophe') }
      let!(:slider3) { create(:slider, user: user, title: 'Overnight Sensation') }

      it 'shows the add new slider button' do
        visit dashboard_sliders_path
        expect(page).to_not have_selector('.button--lock')
        expect(page).to have_link('Add New Slider', href: new_dashboard_slider_path)
      end

      it 'does not show restricted sliders' do
        visit dashboard_sliders_path
        expect(page).to_not have_content('Access to the following sliders requires the Premium plan')
      end
    end
  end
end
