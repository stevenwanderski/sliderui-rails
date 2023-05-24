require 'spec_helper'

describe 'Subscription' do
  let(:user) { create(:user, status: 'trial') }

  before do
    login_as(user, scope: :user)

    allow(Stripe::Checkout::Session).to receive(:retrieve).and_return({
      customer: 'cus_123'
    })
  end

  describe 'Success' do
    it 'updates the user to "paid"' do
      visit dashboard_subscription_success_path

      expect(page).to have_content('Thank you for purchasing SliderUI!')
      expect(user.reload.status).to eq('paid')
      expect(user.stripe_customer_id).to eq('cus_123')
      expect(user.stripe_purchased_at).to be_present
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
