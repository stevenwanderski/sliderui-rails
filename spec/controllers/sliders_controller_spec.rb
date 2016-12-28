require 'spec_helper'

describe SlidersController do
  describe "GET show" do
    context 'when slider is unconfirmed' do
      it 'renders the unconfirmed template' do
        user = create(:user, confirmed: false)
        slider = create(:slider, created_at: 25.hours.ago, user: user)

        get :show, format: :js, short_code: slider.short_code

        expect(response).to render_template('sliders/unconfirmed.js.erb')
      end
    end
  end
end
