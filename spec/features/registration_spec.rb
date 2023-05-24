require 'spec_helper'

describe 'Registration Flow' do
  it 'creates a user with a free trial' do
    visit new_user_registration_path

    submit_registration

    user = User.first
    free_trial_days = (user.trial_ends_at - Time.now).seconds.in_days.ceil
    expect(free_trial_days).to eq(14)
    expect(user.status).to eq('trial')
  end

  it 'sends mailers' do
    visit new_user_registration_path

    submit_registration

    expect(ActionMailer::Base.deliveries.count).to eq(2)
  end
end

def submit_registration
  fill_in 'Email', with: 'frank@zappa.com'
  fill_in 'Password', with: 'testtest'
  fill_in 'Password confirmation', with: 'testtest'
  click_button 'Create account'
  expect(page).to have_content('Get started by adding a new image.')
end
