require 'spec_helper'

describe User do
  describe '#can_add_slider?' do
    context 'premium plan' do
      it 'returns true' do
        user = create(:user, subscription_type: 'premium', subscription_status: 'active')

        expect(user.can_add_slider?).to eq(true)
      end
    end

    context 'free plan' do
      context 'slider count is less than allowed max' do
        it 'returns true' do
          allow(Subscription).to receive(:get_max_slider_count).and_return(1)
          user = create(:user, subscription_type: 'free')

          expect(user.can_add_slider?).to eq(true)
        end
      end

      context 'slider count is greater than or equal to allowed max' do
        it 'returns false' do
          allow(Subscription).to receive(:get_max_slider_count).and_return(1)
          user = create(:user, subscription_type: 'free')
          slider = create(:slider, user: user)

          expect(user.can_add_slider?).to eq(false)
        end
      end
    end
  end

  describe '#update_to_free!' do
    it 'updates subscription type and makes all but newest slider restricted' do
      user = create(:user, subscription_type: 'premium')
      slider1 = create(:slider, user: user, restricted: false, created_at: 2.days.ago)
      slider2 = create(:slider, user: user, restricted: false, created_at: 10.days.ago)

      user.update_to_free!

      expect(user.reload.subscription_type).to eq('free')
      expect(slider1.reload.restricted?).to eq(false)
      expect(slider2.reload.restricted?).to eq(true)
    end
  end

  describe '#update_to_premium!' do
    it 'updates subscription type and makes all sliders not restricted' do
      stripe_customer_id = 'cus_123'
      user = create(:user, subscription_type: 'free', stripe_customer_id: nil)
      slider1 = create(:slider, user: user, restricted: true)
      slider2 = create(:slider, user: user, restricted: true)

      user.update_to_premium!(stripe_customer_id)

      expect(user.reload.subscription_type).to eq('premium')
      expect(user.stripe_customer_id).to eq(stripe_customer_id)
      expect(slider1.reload.restricted?).to eq(false)
      expect(slider2.reload.restricted?).to eq(false)
    end
  end
end
