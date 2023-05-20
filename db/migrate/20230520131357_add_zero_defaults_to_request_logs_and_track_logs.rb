class AddZeroDefaultsToRequestLogsAndTrackLogs < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:sliders, :request_logs_count, 0)
    change_column_default(:sliders, :track_logs_count, 0)
  end
end
