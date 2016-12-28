require 'spec_helper'

describe Slider do
  describe '#confirmed?' do
    context 'when slider was created over 24 hours ago' do
      context 'and user is not confirmed' do
        it 'returns false' do
          user = create(:user, confirmed: false)
          slider = create(:slider, created_at: 25.hours.ago, user: user)

          expect(slider.confirmed?).to eq(false)
        end
      end

      context 'and user is confirmed' do
        it 'returns true' do
          user = create(:user, confirmed: true)
          slider = create(:slider, created_at: 25.hours.ago, user: user)

          expect(slider.confirmed?).to eq(true)
        end
      end
    end

    context 'when slider was created less than 24 hours ago' do
      it 'returns true' do
        slider = create(:slider, created_at: 23.hours.ago)
        
        expect(slider.confirmed?).to eq(true)
      end
    end
  end
end
