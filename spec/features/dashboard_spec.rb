require 'spec_helper'

describe 'Dashboard' do
  before do
    login_as(user, scope: :user)
  end

  context 'user subscription type is blank' do
    let(:user) { create(:user, subscription_type: nil) }

    it 'redirects to pricing page' do
      visit new_dashboard_slider_path

      expect(page).to have_content('Select Plan')
    end
  end
end
