class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]

    mail(to: @user.email, subject: 'Welcome to SliderUI')
  end

  def trial_reminder
    @user = params[:user]

    mail(to: @user.email, subject: 'Your SliderUI trial will expire in 7 days')
  end

  def admin_notify
    @user = params[:user]

    mail(to: 'steven.wanderski@gmail.com', subject: 'New SliderUI user!')
  end
end
