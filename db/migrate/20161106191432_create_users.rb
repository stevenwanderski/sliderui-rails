class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :password
      t.string :token
      t.boolean :confirmed, default: false

      t.timestamps null: false
    end
  end
end
