class AdminMailerPreview < ActionMailer::Preview
  def new_user
    user = User.where.not(trial_ends_at: nil).first
    AdminMailer.with(user: user).new_user
  end

  def new_payment
    user = User.where.not(trial_ends_at: nil).first
    AdminMailer.with(user: user).new_payment
  end
end
