require 'spec_helper'

describe 'Account' do
  let(:user) { create(:user, subscription_status: subscription_status) }
  let(:subscription_status) { nil }

  before do
    login_as(user, scope: :user)
  end

  describe 'Account Portal' do
    context 'when a user is subscribed' do
      let(:subscription_status) { 'subscribed' }

      it 'shows a customer portal link' do
        allow(Stripe::BillingPortal::Session).to receive(:create).and_return({ url: 'portal.com' })
        visit dashboard_account_path

        expect(page).to have_link('Account portal', href: 'portal.com')
      end
    end

    context 'when a user does is not subscribed' do
      let(:subscription_status) { 'trial' }

      it 'shows a checkout link' do
        allow(Stripe::Checkout::Session).to receive(:create).and_return({ url: 'checkout.com' })
        visit dashboard_account_path

        expect(page).to have_link('Account portal', href: 'checkout.com')
      end
    end
  end

  describe 'Password' do
    let(:subscription_status) { 'trial' }

    it 'updates the user password' do
      allow(Stripe::Checkout::Session).to receive(:create).and_return({ url: 'fake.com' })

      visit dashboard_account_path
      fill_in 'Password', with: 'Testtest00'
      fill_in 'Password confirmation', with: 'Testtest00'
      click_button 'Submit'

      expect(page).to have_content('Successfully saved.')
      expect(user.reload.valid_password?('Testtest00')).to eq(true)
    end
  end
end
