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

  desc 'Expire trials'
  task expire_trials: :environment do
    Rails.logger.info('[TRIAL EXPIRES] Starting check...')

    users = User.where(status: 'trial').where('trial_ends_at < ?', Time.now)

    users.each do |user|
      user.expire_free_trial!
      Rails.logger.info("[TRIAL EXPIRES] Expired user: #{user.email}")
    end

    Rails.logger.info("[TRIAL EXPIRES] Done.")
  end
end