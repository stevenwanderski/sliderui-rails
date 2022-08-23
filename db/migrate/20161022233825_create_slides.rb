class CreateSlides < ActiveRecord::Migration[5.2]
  def change
    create_table :slides, id: :uuid do |t|
      t.uuid :slider_id, null: false
      t.text :content
      t.integer :weight, default: 0, null: false
      t.string :image

      t.timestamps null: false
    end
  end
end
