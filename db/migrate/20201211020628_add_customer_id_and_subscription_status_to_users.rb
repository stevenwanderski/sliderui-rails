class AddCustomerIdAndSubscriptionStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_customer_id, :string
    add_column :users, :subscription_status, :string, default: 'active'
  end
end
