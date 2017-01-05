require 'spec_helper'
include AuthHelper

describe 'Authenticated Slider Flow', js: true do
  before :each do
    @user = create(:user, email: 'frank@zappa.com', password: 'testtest')
    @slider = create(:slider, user: @user)
    login('frank@zappa.com', 'testtest')

    click_link @slider.title
    click_link 'Embed Slider'
  end

  describe 'Embed code page' do
    it 'provides the embed code' do
      expect(page).to have_content(@slider.short_code)
    end

    it 'does not show the email / password form' do
      expect(page).to_not have_css('input[name="email"]')
    end
  end
end
