require 'spec_helper'

describe 'Account' do
  let(:user) { create(:user, status: status, stripe_purchased_at: stripe_purchased_at) }
  let(:status) { nil }
  let(:stripe_purchased_at) { nil }

  before do
    login_as(user, scope: :user)
  end

  describe 'Account Portal' do
    context 'when a user is paid' do
      let(:status) { 'paid' }
      let(:stripe_purchased_at) { Date.new(2023, 5, 19) }

      it 'shows a the paid date' do
        visit dashboard_account_path

        expect(page).to have_content('Paid on: 05/19/2023')
      end
    end

    context 'when a user is in free trial' do
      let(:status) { 'trial' }

      it 'shows a checkout link' do
        visit dashboard_account_path

        expect(page).to have_link('Upgrade Account')
      end
    end
  end

  describe 'Password' do
    let(:status) { 'trial' }

    it 'updates the user password' do
      visit dashboard_account_path
      fill_in 'Password', with: 'Testtest00'
      fill_in 'Password confirmation', with: 'Testtest00'
      click_button 'Submit'

      expect(page).to have_content('Successfully saved.')
      expect(user.reload.valid_password?('Testtest00')).to eq(true)
    end
  end
end
