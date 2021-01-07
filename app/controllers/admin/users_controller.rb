class Admin::UsersController < AdminController
  def index
    @users = User.order(created_at: :desc).page(params[:page]).per(50)
    @free_count = User.where(subscription_type: 'free').count
    @premium_count = User.where(subscription_type: 'premium').count
  end
end
