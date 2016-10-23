class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides, id: :uuid do |t|
      t.uuid :slider_id, null: false
      t.text :content

      t.timestamps null: false
    end
  end
end
