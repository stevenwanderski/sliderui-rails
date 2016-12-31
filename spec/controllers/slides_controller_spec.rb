require 'spec_helper'

describe Api::SlidesController do
  describe 'POST create' do
    context 'user owns slider' do
      it 'creates and renders the slide' do
        user = create(:user)
        slider = create(:slider, user: user)
        @request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{user.token}\""
        post_params = { slide: { slider_id: slider.id } }

        post :create, post_params

        expect(Slide.count).to eq(1)
        json = JSON.parse(response.body)
        expect(json['id']).to eq(Slide.first.id)
      end
    end

    context 'user does not own slider' do
      it 'does not create the slide and renders forbidden' do
        user1 = create(:user, email: 'frank1@zappa.com')
        user2 = create(:user, email: 'frank2@zappa.com')
        slider = create(:slider, user: user2)
        @request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{user1.token}\""
        post_params = { slide: { slider_id: slider.id } }

        post :create, post_params

        expect(Slide.count).to eq(0)
        json = JSON.parse(response.body)
        expect(json['errors']).to be_present
      end
    end
  end

  describe 'PUT update' do
    context 'user owns slider' do
      it 'updates and renders the slide' do
        user = create(:user)
        slider = create(:slider, user: user)
        slide = create(:slide, slider: slider)
        @request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{user.token}\""
        put_params = { id: slide.id, slide: { content: 'new content' } }

        put :update, put_params

        expect(slide.reload.content).to eq('new content')
        json = JSON.parse(response.body)
        expect(json['id']).to eq(Slide.first.id)
      end
    end

    context 'user does not own slider' do
      it 'does not update the slide and renders forbidden' do
        user1 = create(:user, email: 'frank1@zappa.com')
        user2 = create(:user, email: 'frank2@zappa.com')
        slider = create(:slider, user: user2)
        slide = create(:slide, slider: slider)
        @request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{user1.token}\""
        put_params = { id: slide.id, slide: { content: 'new content' } }

        put :update, put_params

        expect(slide.reload.content).to_not eq('new content')
        json = JSON.parse(response.body)
        expect(json['errors']).to be_present
      end
    end
  end

  describe 'DELETE destroy' do
    context 'user owns slider' do
      it 'deletes the slide' do
        user = create(:user)
        slider = create(:slider, user: user)
        slide = create(:slide, slider: slider)
        @request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{user.token}\""

        delete :destroy, id: slide.id

        expect(Slide.count).to eq(0)
      end
    end

    context 'user does not own slider' do
      it 'does not delete the slide' do
        user1 = create(:user, email: 'frank1@zappa.com')
        user2 = create(:user, email: 'frank2@zappa.com')
        slider = create(:slider, user: user2)
        slide = create(:slide, slider: slider)
        @request.env['HTTP_AUTHORIZATION'] = "Token token=\"#{user1.token}\""

        delete :destroy, id: slide.id

        expect(Slide.count).to eq(1)
        json = JSON.parse(response.body)
        expect(json['errors']).to be_present
      end
    end
  end
end
