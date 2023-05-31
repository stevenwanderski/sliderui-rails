class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]

    mail(to: @user.email, subject: 'Welcome to SliderUI')
  end

  def trial_reminder
    @user = params[:user]

    mail(to: @user.email, subject: "Your SliderUI trial will expire in #{@user.trial_days} days")
  end

  def payment_success
    @user = params[:user]

    mail(to: @user.email, subject: 'Thank you for your SliderUI purchase')
  end

  def admin_notify
    @user = params[:user]

    mail(to: 'steven.wanderski@gmail.com', subject: 'New SliderUI User')
  end

  def admin_payment_success
    @user = params[:user]

    mail(to: 'steven.wanderski@gmail.com', subject: '💰 SliderUI Payment!')
  end
end
