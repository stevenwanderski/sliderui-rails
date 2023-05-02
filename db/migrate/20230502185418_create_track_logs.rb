class CreateTrackLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :track_logs do |t|
      t.string :short_code
      t.text :url

      t.timestamps
    end
  end
end
