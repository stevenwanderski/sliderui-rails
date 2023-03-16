require 'spec_helper'

describe SlidersController do
  describe '#show' do
    it 'renders the slides' do
      slider = create(:slider)
      slide = create(:slide, slider: slider)

      get :show, params: { short_code: slider.short_code, format: 'js' }

      expect(response.code).to eq('200')
      expect(assigns[:output]).to match('dags.jpg')
    end

    it 'creates a request log' do
      slider = create(:slider)
      slide = create(:slide, slider: slider)

      expect {
        get :show, params: { short_code: slider.short_code, format: 'js' }
      }.to change(RequestLog, :count).by(1)
    end

    context 'slider is restricted' do
      it 'shows the restricted message' do
        allow_any_instance_of(Slider).to receive(:restricted?).and_return(true)
        slider = create(:slider)

        get :show, params: { short_code: slider.short_code, format: 'js' }

        expect(response.code).to eq('200')
        expect(assigns[:output]).to match('This SliderUI image gallery is only available with the premium plan.')
      end
    end
  end
end
