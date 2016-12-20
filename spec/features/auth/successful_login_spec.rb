require 'spec_helper'

context 'Auth', js: true do
  describe 'Successful login' do
    it 'logs in the user and redirects to sliders page' do
      user = create(:user, email: 'frank@zappa.com', password: 'test', confirmed: true)

      visit '/auth'
      find('input[name="email"]').set('frank@zappa.com')
      find('input[name="password"]').set('test')
      find('button').click

      expect(page).to have_content('frank@zappa.com')
    end
  end
end
