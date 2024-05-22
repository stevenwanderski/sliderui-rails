class AddExpiredOutreachSentAtToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :expired_outreach_sent_at, :datetime
  end
end
