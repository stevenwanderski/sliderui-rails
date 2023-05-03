class Admin::TrackLogsController < AdminController
  def index
    @track_logs = TrackLog.order(created_at: :desc).page(params[:page]).per(50)
  end
end
