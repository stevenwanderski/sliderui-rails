namespace :user do
  desc 'Send trial reminder'
  task send_trial_reminders: :environment do
    users = User
      .where.not(trial_ends_at: nil)
      .where(status: 'trial', trial_reminder_sent_at: nil)

    users.each do |user|
      if (user.trial_ends_at - 7.days).to_date == Date.today
        UserMailer.with(user: user).trial_reminder.deliver_now
        user.update!(trial_reminder_sent_at: Time.now)
      end
    end
  end
end