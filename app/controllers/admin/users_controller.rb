class Admin::UsersController < AdminController
  def index
    @q = User.ransack(params[:q])

    @users = @q.result
      .where('users.created_at > ?', DateTime.new(2023, 5, 19, 22, 0, 0, '-05:00'))
      .includes(:sliders)
      .order('users.created_at desc')
      .page(params[:page])
      .per(50)
  end

  def send_expired_outreach
    user = User.find(params[:id])

    user.send_expired_outreach!

    redirect_to admin_users_path, notice: "Expired outreach mailer was sent to #{user.email}"
  end
end
