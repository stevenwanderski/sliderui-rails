class RemoveDefaultSubscriptionFromUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:users, :subscription_type, nil)
    change_column_default(:users, :subscription_status, nil)
  end
end
