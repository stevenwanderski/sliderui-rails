class AddStripeTransactionIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :stripe_transaction_id, :string
  end
end
