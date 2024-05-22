class UnsubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find(params[:user_id])

    user.unsubscribe!

    redirect_to unsubscribe_success_path(user_id: user.id)
  end

  def show
    @user = User.find(params[:user_id])
  end
end