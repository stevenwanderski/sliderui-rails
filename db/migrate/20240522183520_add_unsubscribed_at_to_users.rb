class AddUnsubscribedAtToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :unsubscribed_at, :datetime
  end
end
