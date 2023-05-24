class AdminMailer < ApplicationMailer
  def new_user
    @user = params[:user]

    mail(to: 'steven.wanderski@gmail.com', subject: 'New SliderUI User')
  end

  def new_payment
    @user = params[:user]

    mail(to: 'steven.wanderski@gmail.com', subject: '💰 SliderUI Payment!')
  end
end
