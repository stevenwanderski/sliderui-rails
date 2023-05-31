namespace :user do
  desc 'Send trial reminder'
  task send_trial_reminders: :environment do
    ap ('[TRIAL REMINDERS] Starting check...')

    users = User.where(status: 'trial', trial_reminder_sent_at: nil).order(trial_ends_at: :asc)

    users.each do |user|
      if user.trial_days == 7
        UserMailer.with(user: user).trial_reminder.deliver_now
        user.update!(trial_reminder_sent_at: Time.now)
        ap ("[TRIAL REMINDERS] Sent to #{user.email}")
      end
    end

    ap ("[TRIAL REMINDERS] Done.")
  end
end