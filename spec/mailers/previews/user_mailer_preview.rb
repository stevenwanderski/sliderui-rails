class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    user = User.where.not(trial_ends_at: nil).first
    UserMailer.with(user: user).welcome_email
  end

  def trial_reminder
    user = User.where.not(trial_ends_at: nil).first
    UserMailer.with(user: user).trial_reminder
  end

  def admin_notify
    user = User.where.not(trial_ends_at: nil).first
    UserMailer.with(user: user).admin_notify
  end
end
