class RemoveRestrictedFromSliders < ActiveRecord::Migration[5.2]
  def change
    remove_column :sliders, :restricted, :boolean
  end
end
