class AddSubscriptionTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscription_type, :string, default: 'free'
  end
end
