class AddTrialReminderSentAtToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :trial_reminder_sent_at, :datetime
  end
end
