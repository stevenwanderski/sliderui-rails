class AddSubscriptionTypeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :subscription_type, :string, default: 'free'
  end
end
