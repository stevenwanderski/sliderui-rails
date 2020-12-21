require 'spec_helper'
include AuthHelper

context 'Login' do
  describe 'Successful login' do
    it 'logs in the user and redirects to sliders page' do
      user = create(:user, email: 'frank@zappa.com', password: 'testtest', confirmed: true)

      visit '/users/sign_in'
      find('input[name="user_email"]').set('frank@zappa.com')
      find('input[name="user_password"]').set('testtest')
      find('button').click

      expect(page).to have_content('frank@zappa.com')
    end
  end

  describe 'Unsuccessful login' do
    it 'displays the error message' do
      user = create(:user, email: 'frank@zappa.com', password: 'test', confirmed: true)

      visit '/auth'
      find('input[name="email"]').set('frank@zappa.comXX')
      find('input[name="password"]').set('testXX')
      find('button').click

      expect(page).to have_content('Incorrect login.')
    end
  end

  describe 'Authenticated user' do
    it 'redirects to sliders page' do
      @user = create(:user, email: 'frank@zappa.com', password: 'testtest')
      login('frank@zappa.com', 'testtest')
      visit '/auth'
      expect(page).to have_content('My Sliders')
    end
  end
end
