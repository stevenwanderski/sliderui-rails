# require 'spec_helper'

# describe WebhooksController do
#   describe '#stripe' do
#     let(:event_type) { nil }
#     let(:subscription_type) { nil }
#     let!(:user) { create(:user, subscription_type: subscription_type, stripe_customer_id: 'cus_123') }

#     before do
#       object = double(customer: 'cus_123')
#       data = double(object: object)
#       event = double(type: event_type, data: data)
#       allow(Stripe::Webhook).to receive(:construct_event).and_return(event)

#       post :stripe
#     end

#     describe 'customer.subscription.deleted' do
#       let(:event_type) { 'customer.subscription.deleted' }
#       let(:subscription_type) { 'premium' }

#       it 'converts user to free plan' do
#         expect(user.reload.subscription_type).to eq('free')
#       end
#     end

#     describe 'invoice.paid' do
#       let(:event_type) { 'invoice.paid' }
#       let(:subscription_type) { 'free' }

#       it 'converts user to premium plan' do
#         expect(user.reload.subscription_type).to eq('premium')
#       end
#     end

#     describe 'invoice.payment_failed' do
#       let(:event_type) { 'invoice.payment_failed' }
#       let(:subscription_type) { 'premium' }

#       it 'converts user to free plan' do
#         expect(user.reload.subscription_type).to eq('free')
#       end
#     end
#   end
# end
