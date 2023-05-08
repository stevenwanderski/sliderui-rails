class AddVersionToSliders < ActiveRecord::Migration[7.0]
  def change
    add_column :sliders, :version, :integer
  end
end
