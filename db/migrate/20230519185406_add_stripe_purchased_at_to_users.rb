class AddStripePurchasedAtToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :stripe_purchased_at, :datetime
  end
end
