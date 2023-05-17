class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]

    mail(to: @user.email, subject: 'Welcome to SliderUI')
  end

  def trial_reminder
    @user = params[:user]

    mail(to: @user.email, subject: 'Your SliderUI trial will expire in 7 days')
  end
end
