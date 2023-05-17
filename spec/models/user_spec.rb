require 'spec_helper'

describe User do
  describe '.days_to_expire' do
    it 'returns all users with X days until expired trial' do
      u1 = create(:user, trial_ends_at: 8.5.days.from_now, email: 'frank+1@zappa.com')
      u2 = create(:user, trial_ends_at: 7.days.from_now, email: 'frank+2@zappa.com')
      u3 = create(:user, trial_ends_at: 7.days.from_now, email: 'frank+3@zappa.com')
      u4 = create(:user, trial_ends_at: 6.days.from_now, email: 'frank+4@zappa.com')

      expect(User.days_to_expire(7).ids).to match_array([u2.id, u3.id])
    end
  end
end
