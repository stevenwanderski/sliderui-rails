class Admin::UsersController < AdminController
  def index
    @users = User
      .where('created_at > ?', DateTime.new(2023, 5, 19, 22, 0, 0, '-05:00'))
      .order(created_at: :desc)
      .page(params[:page])
      .per(50)
  end
end
