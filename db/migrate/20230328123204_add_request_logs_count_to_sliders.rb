class AddRequestLogsCountToSliders < ActiveRecord::Migration[7.0]
  def change
    add_column :sliders, :request_logs_count, :integer
  end
end
