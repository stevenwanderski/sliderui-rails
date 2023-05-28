require 'spec_helper'

describe 'Sliders' do
  let(:user) { create(:user, status: 'paid') }

  before do
    login_as(user, scope: :user)
  end

  describe 'create new slider' do
    it 'redirects to slider edit page' do
      visit dashboard_sliders_path

      click_link 'New Slider'

      expect(page).to have_content('Get started by adding a new image.')
    end
  end
end
