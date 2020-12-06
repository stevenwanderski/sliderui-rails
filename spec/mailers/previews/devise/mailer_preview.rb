class Devise::MailerPreview < ActionMailer::Preview
  # hit http://localhost:3000/rails/mailers/devise/mailer/reset_password_instructions
  def reset_password_instructions
    user = User.where.not(email: nil).first
    Devise::Mailer.reset_password_instructions(user, {})
  end
end
