require 'spec_helper'

describe Api::SlidesController do
  let(:user) { create(:user) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end

  describe '#create' do
    it 'creates a slide' do
      slider = create(:slider, user: user)

      post :create, slide: { slider_id: slider.id, weight: 99 }

      expect(response.code).to eq('200')
      expect(slider.slides.count).to eq(1)
    end

    context 'user does not own the slider' do
      it 'renders 401' do
        other_user = create(:user, email: 'other@user.com')
        slider = create(:slider, user: other_user)

        post :create, slide: { slider_id: slider.id, weight: 99 }

        expect(response.code).to eq('401')
        expect(slider.slides.count).to eq(0)
      end
    end
  end

  describe '#destroy' do
    it 'destroys the slide' do
      slider = create(:slider, user: user)
      slide = create(:slide, slider: slider)

      delete :destroy, id: slide.id

      expect(response.code).to eq('200')
      expect(slider.slides.count).to eq(0)
    end

    context 'user does not own the slide' do
      it 'renders 401' do
        other_user = create(:user, email: 'other@user.com')
        slider = create(:slider, user: other_user)
        slide = create(:slide, slider: slider)

        delete :destroy, id: slide.id

        expect(response.code).to eq('401')
        expect(slider.slides.count).to eq(1)
      end
    end
  end

  describe '#update_collection' do
    it 'updates the weights' do
      slider = create(:slider, user: user)
      slide1 = create(:slide, slider: slider, weight: 0)
      slide2 = create(:slide, slider: slider, weight: 1)

      data = [
        { id: slide1.id, weight: '87' },
        { id: slide2.id, weight: '66' }
      ]

      put :update_collection, slides: data

      expect(response.code).to eq('200')
      expect(slide1.reload.weight).to eq(87)
      expect(slide2.reload.weight).to eq(66)
    end

    context 'user does not own the slider' do
      it 'renders 401' do
        other_user = create(:user, email: 'other@user.com')
        slider = create(:slider, user: other_user)
        slide1 = create(:slide, slider: slider, weight: 0)
        slide2 = create(:slide, slider: slider, weight: 1)

        data = [
          { id: slide1.id, weight: '87' },
          { id: slide2.id, weight: '66' }
        ]

        put :update_collection, slides: data

        expect(response.code).to eq('401')
        expect(slide1.reload.weight).to eq(0)
        expect(slide2.reload.weight).to eq(1)
      end
    end
  end
end
