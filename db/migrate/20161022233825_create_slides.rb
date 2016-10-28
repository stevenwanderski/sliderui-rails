class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides, id: :uuid do |t|
      t.uuid :slider_id, null: false
      t.text :content
      t.integer :weight, default: 0, null: false

      t.timestamps null: false
    end
  end
end
