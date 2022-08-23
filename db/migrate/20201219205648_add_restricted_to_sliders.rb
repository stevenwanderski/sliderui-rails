class AddRestrictedToSliders < ActiveRecord::Migration[5.2]
  def change
    add_column :sliders, :restricted, :boolean, default: false
  end
end
