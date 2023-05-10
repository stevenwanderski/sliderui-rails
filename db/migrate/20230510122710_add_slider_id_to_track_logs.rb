class AddSliderIdToTrackLogs < ActiveRecord::Migration[7.0]
  def change
    add_column :track_logs, :slider_id, :uuid
  end
end
