class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    user = User.where.not(trial_ends_at: nil).first
    UserMailer.with(user: user).welcome_email
  end

  def trial_expired
    user = User.where.not(trial_ends_at: nil).first
    UserMailer.with(user: user).trial_expired
  end

  def trial_reminder
    user = User.where.not(trial_ends_at: nil).first
    UserMailer.with(user: user).trial_reminder
  end

  def payment_success
    user = OpenStruct.new(
      email: 'frank@zappa.com',
      stripe_purchased_at: Time.now,
      stripe_transaction_id: 'pi_123456789abcdefghijkl'
    )

    UserMailer.with(user: user).payment_success
  end

  def expired_outreach
    user = User.where.not(email: nil).first
    UserMailer.with(user: user).expired_outreach
  end
end
