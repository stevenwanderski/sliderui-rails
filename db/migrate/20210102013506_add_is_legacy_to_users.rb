class AddIsLegacyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_legacy, :boolean, default: false
  end
end
