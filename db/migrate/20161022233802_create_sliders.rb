class CreateSliders < ActiveRecord::Migration[5.2]
  def change
    create_table :sliders, id: :uuid do |t|
      t.uuid :user_id
      t.string :title
      t.string :short_code
      t.jsonb :settings, default: '{}'

      t.timestamps null: false
    end

    add_index :sliders, :short_code, unique: true
  end
end
