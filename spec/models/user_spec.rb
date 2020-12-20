require 'spec_helper'

describe User do
  describe '#can_add_slider?' do
    context 'active premium' do
      it 'returns true' do
        user = create(:user, subscription_type: 'premium', subscription_status: 'active')

        expect(user.can_add_slider?).to eq(true)
      end
    end

    context 'free and zero sliders' do
      it 'returns true' do
        user = create(:user, subscription_type: 'free')

        expect(user.can_add_slider?).to eq(true)
      end
    end

    context 'free and has sliders' do
      it 'returns false' do
        user = create(:user, subscription_type: 'free')
        slider = create(:slider, user: user)

        expect(user.can_add_slider?).to eq(false)
      end
    end
  end

  describe '#convert_sliders_to_free!' do
    it 'saves all user sliders as restricted true except the most recent' do
      user = create(:user)
      slider1 = create(:slider, user: user, restricted: false, created_at: 2.days.ago)
      slider2 = create(:slider, user: user, restricted: false, created_at: 10.days.ago)

      user.convert_sliders_to_free!

      expect(slider1.reload.restricted?).to eq(false)
      expect(slider2.reload.restricted?).to eq(true)
    end
  end

  describe '#convert_sliders_to_premium!' do
    it 'saves all user sliders as restricted false' do
      user = create(:user)
      slider1 = create(:slider, user: user, restricted: true)
      slider2 = create(:slider, user: user, restricted: true)

      user.convert_sliders_to_premium!

      expect(slider1.reload.restricted?).to eq(false)
      expect(slider2.reload.restricted?).to eq(false)
    end
  end
end
