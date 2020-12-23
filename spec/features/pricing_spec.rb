require 'spec_helper'

describe 'Pricing' do
  before do
    login_as(user, scope: :user)
  end

  context 'user subscription type is not blank' do
    let(:user) { create(:user, subscription_type: 'free') }

    it 'redirects to dashboard page' do
      visit dashboard_pricing_path

      expect(page).to have_content('Create your first slider!')
    end
  end
end
