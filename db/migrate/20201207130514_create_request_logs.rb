class CreateRequestLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :request_logs do |t|
      t.uuid :slider_id
      t.uuid :user_id
      t.text :referrer

      t.timestamps null: false
    end
  end
end
