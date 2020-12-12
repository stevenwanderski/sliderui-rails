require 'spec_helper'

describe WebhooksController do
  describe '#stripe' do
    let(:email) { 'frank@zappa.com' }
    let!(:user) { create(:user, email: email, subscription_type: 'free') }

    let(:event) do
      {
        "id": "evt_1HxAgKJGhZXsnHlsFqSKJGaX",
        "object": "event",
        "api_version": "2020-08-27",
        "created": 1607689508,
        "data": {
          "object": {
            "id": "cs_test_a1qA9eyhMcOjcJc8r1PZL0mnAt1i26zkh4Kxullo4OPQRGBrsO2B78EQMR",
            "object": "checkout.session",
            "allow_promotion_codes": nil,
            "amount_subtotal": 500,
            "amount_total": 500,
            "billing_address_collection": nil,
            "cancel_url": "https://sliderui-staging.herokuapp.com/dashboard/subscription/edit?cancel=true",
            "client_reference_id": nil,
            "currency": "usd",
            "customer": "cus_IYHE4UuJctGAJ7",
            "customer_email": email,
            "livemode": false,
            "locale": nil,
            "metadata": {
            },
            "mode": "subscription",
            "payment_intent": nil,
            "payment_method_types": [
              "card"
            ],
            "payment_status": "paid",
            "setup_intent": nil,
            "shipping": nil,
            "shipping_address_collection": nil,
            "submit_type": nil,
            "subscription": "sub_IYHEToXM4ACv9Y",
            "success_url": "https://sliderui-staging.herokuapp.com/dashboard/subscription/edit?session_id={CHECKOUT_SESSION_ID}",
            "total_details": {
              "amount_discount": 0,
              "amount_tax": 0
            }
          }
        },
        "livemode": false,
        "pending_webhooks": 3,
        "request": {
          "id": "req_aFNPkERrzCew6k",
          "idempotency_key": nil
        },
        "type": "checkout.session.completed"
      }
    end

    it 'sets the subscription type as paid' do
      post :stripe, params: event

      expect(user.reload.subscription_type).to eq('paid')
    end
  end
end
