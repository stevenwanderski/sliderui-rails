class RenameSubscriptionStatusToStatus < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :subscription_status, :status
  end
end
