require 'spec_helper'

describe 'Trial Expired' do
  let(:user) { create(:user, status: 'expired') }
  let!(:slider) { create(:slider, user: user) }

  before do
    login_as(user, scope: :user)
  end

  describe 'slider edit page' do
    it 'shows the trial expired display' do
      visit dashboard_edit_slider_path(short_code: slider.short_code)

      expect_trial_expired_display
    end
  end

  describe 'slider list page' do
    it 'shows the trial expired display' do
      visit dashboard_sliders_path

      expect_trial_expired_display
    end
  end

  def expect_trial_expired_display
    expect(page).to have_content('Your free trial has expired.')
    expect(page).to have_link('Upgrade subscription plan', href: dashboard_subscription_checkout_path)
  end
end
