class CreateSliders < ActiveRecord::Migration
  def change
    create_table :sliders, id: :uuid do |t|
      t.string :title
      t.uuid :user_id
      t.uuid :temp_user_id

      t.timestamps null: false
    end
  end
end
