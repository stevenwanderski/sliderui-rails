class CreateSliders < ActiveRecord::Migration
  def change
    create_table :sliders, id: :uuid do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
