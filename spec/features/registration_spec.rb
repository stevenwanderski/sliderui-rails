require 'spec_helper'

describe 'Registration Flow' do
  it 'creates the user' do
    visit new_user_registration_path

    fill_in 'user_email', with: 'frank@zappa.com'
    fill_in 'user_password', with: 'testtest'
    fill_in 'user_password_confirmation', with: 'testtest'
    click_button 'Submit'
    expect(page).to have_content('Select Plan')

    find('[data-plan="free"]').click
    expect(page).to have_content('Create your first slider!')
  end
end
