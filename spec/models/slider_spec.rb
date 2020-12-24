require 'spec_helper'

describe Slider do
  describe '#display_image_url' do
    it 'returns the first slide image url' do
      slider = create(:slider)
      slide1 = create(:slide, slider: slider, weight: 99)
      slide2 = create(:slide, slider: slider, weight: 10)
      slide3 = create(:slide, slider: slider, weight: 20)

      expect(slider.display_image_url).to eq(slide2.image.url)
    end

    context 'no slides exist' do
      it 'returns nil' do
        slider = create(:slider)

        expect(slider.display_image_url).to eq(nil)
      end
    end
  end

  describe '#set_short_code' do
    it 'sets a unique short code on create' do
      slider = create(:slider)

      expect(slider.short_code.length).to eq(6)
    end
  end

  describe '.slides' do
    it 'sorts by weight' do
      slider = create(:slider)
      slide1 = create(:slide, slider: slider, weight: 99)
      slide2 = create(:slide, slider: slider, weight: 10)
      slide3 = create(:slide, slider: slider, weight: 20)

      expect(slider.slides[0].id).to eq(slide2.id)
      expect(slider.slides[1].id).to eq(slide3.id)
      expect(slider.slides[2].id).to eq(slide1.id)
    end
  end
end
