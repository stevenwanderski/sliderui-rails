users = User.where(status: 'trial', trial_reminder_sent_at: nil).order(trial_ends_at: :asc)

users.each do |user|
  if user.trial_days == 7
    UserMailer.with(user: user).trial_reminder.deliver_now
    user.update!(trial_reminder_sent_at: Time.now)
  end
end