class AddRestrictedToSliders < ActiveRecord::Migration
  def change
    add_column :sliders, :restricted, :boolean, default: false
  end
end
