require 'spec_helper'

describe 'Registration Flow' do
  it 'creates a user with a free trial' do
    visit new_user_registration_path

    fill_in 'Email', with: 'frank@zappa.com'
    fill_in 'Password', with: 'testtest'
    fill_in 'Password confirmation', with: 'testtest'
    click_button 'Create account'
    expect(page).to have_content('Get started by creating a new slider!')

    user = User.first
    free_trial_days = (user.trial_ends_at - Time.now).seconds.in_days.ceil
    expect(free_trial_days).to eq(14)
    expect(user.subscription_status).to eq('trial')
  end
end
