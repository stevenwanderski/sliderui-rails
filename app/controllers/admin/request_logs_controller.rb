class Admin::RequestLogsController < AdminController
  def index
    @request_logs = RequestLog.order(created_at: :desc).page(params[:page]).per(50)
  end
end
