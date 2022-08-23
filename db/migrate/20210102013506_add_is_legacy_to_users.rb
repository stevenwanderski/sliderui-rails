class AddIsLegacyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_legacy, :boolean, default: false
  end
end
