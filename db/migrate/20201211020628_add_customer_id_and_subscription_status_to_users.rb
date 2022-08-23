class AddCustomerIdAndSubscriptionStatusToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :stripe_customer_id, :string
    add_column :users, :subscription_status, :string, default: 'active'
  end
end
