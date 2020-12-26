class RemoveRestrictedFromSliders < ActiveRecord::Migration
  def change
    remove_column :sliders, :restricted, :boolean
  end
end
