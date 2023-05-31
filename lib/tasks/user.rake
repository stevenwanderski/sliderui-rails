namespace :user do
  desc 'Send trial reminder'
  task send_trial_reminders: :environment do
    Rails.logger.info('[TRIAL REMINDERS] Starting check...')

    users = User.where(status: 'trial', trial_reminder_sent_at: nil).order(trial_ends_at: :asc)

    users.each do |user|
      if user.trial_days == 7
        user.send_trial_reminder!
        Rails.logger.info("[TRIAL REMINDERS] Sent to #{user.email}")
      end
    end

    Rails.logger.info("[TRIAL REMINDERS] Done.")
  end
end