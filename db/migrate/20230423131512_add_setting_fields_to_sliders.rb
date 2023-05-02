class AddSettingFieldsToSliders < ActiveRecord::Migration[7.0]
  def change
    add_column :sliders, :width, :string, default: '1600'
    add_column :sliders, :height, :string, default: '250'
    add_column :sliders, :mode, :string, default: 'linear'
    add_column :sliders, :speed, :string, default: '500'
    add_column :sliders, :auto_enabled, :boolean, default: false
    add_column :sliders, :auto_interval, :string, default: '2000'
    add_column :sliders, :controls_enabled, :boolean, default: true
    add_column :sliders, :pager_enabled, :boolean, default: true
  end
end
