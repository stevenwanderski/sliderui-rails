class Admin::UsersController < AdminController
  def index
    @users = User.order(created_at: :desc).page(params[:page]).per(50)
  end
end
