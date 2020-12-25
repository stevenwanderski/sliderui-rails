require 'spec_helper'

describe Subscription do
  describe '.get_cost' do
    it 'returns the plan cost' do
      expect(Subscription.get_cost('free')).to eq(0)
      expect(Subscription.get_cost('premium')).to eq(5)
    end
  end

  describe '.get_label' do
    it 'returns the plan label' do
      expect(Subscription.get_label('free')).to eq('Free')
      expect(Subscription.get_label('premium')).to eq('Premium 🏆')
    end
  end

  describe '.get_max_slider_count' do
    it 'returns the plan max_slider_count' do
      expect(Subscription.get_max_slider_count('free')).to eq(ENV['FREE_SLIDER_MAX'].to_i)
      expect(Subscription.get_max_slider_count('premium')).to eq(nil)
    end
  end

  describe '.get_plan' do
    context 'plan exists' do
      it 'returns the plan' do
        expect(Subscription.get_plan('premium')).to eq('premium')
      end
    end

    context 'plan does not exist' do
      it 'returns "free"' do
        expect(Subscription.get_plan('mothers')).to eq('free')
      end
    end
  end
end
