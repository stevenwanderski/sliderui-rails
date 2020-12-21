require 'spec_helper'

describe Dashboard::SubscriptionController do
  describe '#success' do
    let(:email) { 'frank@zappa.com' }
    let(:payment_status) { 'paid' }
    let(:stripe_email) { email }
    let(:user) { create(:user, email: email, subscription_type: 'free') }

    let(:response) do
      double(
        customer: 'cus_123',
        customer_email: stripe_email,
        payment_status: payment_status
      )
    end

    before do
      allow(Stripe::Checkout::Session).to receive(:retrieve).and_return(response)

      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in(user)
    end

    subject { post :success, session_id: 'ses_123' }

    it 'converts user to premium plan' do
      subject

      expect(user.reload.subscription_type).to eq('premium')
      expect(user.stripe_customer_id).to eq('cus_123')
    end

    context 'email does not match current user' do
      let(:stripe_email) { 'david@bowie.com' }

      it 'does not update the user' do
        subject

        expect(user.reload.subscription_type).to eq('free')
        expect(user.stripe_customer_id).to eq(nil)
      end
    end

    context 'email does not match current user' do
      let(:payment_status) { 'overdue' }

      it 'does not update the user' do
        subject

        expect(user.reload.subscription_type).to eq('free')
        expect(user.stripe_customer_id).to eq(nil)
      end
    end
  end
end
