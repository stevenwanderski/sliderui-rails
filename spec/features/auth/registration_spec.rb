require 'spec_helper'

context 'Registration', js: true do
  describe 'Successful registration' do
    it 'logs in the user and redirects to sliders page' do
      visit '/auth'
      find('input[type="radio"][value="new"]').set(true)
      find('input[name="email"]').set('frank@zappa.com')
      find('input[name="password"]').set('testtest')
      find('button').click

      expect(page).to have_content('frank@zappa.com')
      expect(page).to have_content('Click here to add a slider!')
    end
  end
end
