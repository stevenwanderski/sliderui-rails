require 'spec_helper'
include AuthHelper

describe 'Authenticated Slider Flow', js: true do
  before :each do
    @user = create(:user, email: 'frank@zappa.com', password: 'testtest')
    @slider = create(:slider, user: @user)
    login('frank@zappa.com', 'testtest')

    click_link @slider.title
    expect(page).to have_content('Save Settings')
  end

  describe 'Slider settings page' do
    it 'correctly saves and displays checkbox settings' do
      click_button 'Save Settings'
      expect(page).to have_content('Successfully saved')
      expect(@slider.reload.settings['pager']).to eq(true)

      find('input[name="pager"]').set(false)
      click_button 'Save Settings'
      expect(page).to have_content('Successfully saved')
      expect(@slider.reload.settings['pager']).to eq(false)

      click_link 'Preview'
      expect(page).to have_content('Slider will appear')

      click_link 'Settings'
      expect(page).to have_content('Save Settings')
      expect(find('input[name="pager"]')).to_not be_checked
    end
  end
end
