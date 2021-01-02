require 'spec_helper'

describe User do
  describe '#active_premium?' do
    context 'user is premium and active' do
      it 'returns true' do
        user = build(:user, :premium)

        expect(user.active_premium?).to eq(true)
      end
    end

    context 'user is not premium or active' do
      it 'returns false' do
        user = build(:user, subscription_type: 'free', subscription_status: 'active')
        expect(user.active_premium?).to eq(false)

        user = build(:user, subscription_type: 'premium', subscription_status: 'past_due')
        expect(user.active_premium?).to eq(false)
      end
    end

    context 'user is legacy' do
      it 'returns true' do
        user = build(:user, is_legacy: true)
        expect(user.active_premium?).to eq(true)
      end
    end
  end

  describe '#can_add_slider?' do
    context 'premium plan' do
      it 'returns true' do
        user = create(:user, :premium)

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

  describe '#sliders_unrestricted' do
    before do
      allow(Subscription).to receive(:get_max_slider_count).and_return(1)
    end

    context 'user is premium' do
      it 'returns all sliders' do
        user = create(:user, :premium)
        slider1 = create(:slider, user: user)
        slider2 = create(:slider, user: user)
        slider3 = create(:slider, user: user)

        expect(user.sliders_unrestricted.ids).to eq([slider1.id, slider2.id, slider3.id])
      end
    end

    context 'user is free' do
      it 'returns the newest sliders up to max' do
        user = create(:user, subscription_type: 'free')
        slider1 = create(:slider, user: user, created_at: 5.days.ago)
        slider2 = create(:slider, user: user, created_at: 2.days.ago)
        slider3 = create(:slider, user: user, created_at: 3.days.ago)

        expect(user.sliders_unrestricted.ids).to eq([slider2.id])
      end
    end
  end

  describe '#update_to_free!' do
    it 'updates subscription type' do
      user = create(:user, :premium)

      user.update_to_free!

      expect(user.reload.subscription_type).to eq('free')
    end
  end

  describe '#update_to_premium!' do
    it 'updates subscription type and makes all sliders not restricted' do
      stripe_customer_id = 'cus_123'
      user = create(:user, subscription_type: 'free', stripe_customer_id: nil)

      user.update_to_premium!(stripe_customer_id)

      expect(user.reload.subscription_type).to eq('premium')
      expect(user.stripe_customer_id).to eq(stripe_customer_id)
    end
  end
end
