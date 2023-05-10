class AddTrackLogsCountToSliders < ActiveRecord::Migration[7.0]
  def change
    add_column :sliders, :track_logs_count, :integer
  end
end
