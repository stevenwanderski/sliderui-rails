require 'spec_helper'

describe 'Account' do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end

  describe 'Password' do
    it 'updates the user password' do
      visit edit_dashboard_password_path
      fill_in 'user_password', with: 'Testtest00'
      fill_in 'user_password_confirmation', with: 'Testtest00'
      click_button 'Save'

      expect(page).to have_content('Successfully saved.')
      expect(user.reload.valid_password?('Testtest00')).to eq(true)
    end
  end

  describe 'Subscription' do
    it 'shows the free plan' do
      user.update_to_free!
      visit edit_dashboard_subscription_path
      expect(page).to have_content('Current plan: Free')
      expect(page).to have_button('Upgrade Plan')
    end

    it 'shows the premium plan' do
      user.update_to_premium!('cus_123')
      visit edit_dashboard_subscription_path
      expect(page).to have_content('Current plan: Premium')
      expect(page).to have_button('Manage Subscription')
    end
  end
end
