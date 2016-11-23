class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :encrypted_password
      t.string :encrypted_password_iv
      t.string :token
      t.boolean :confirmed, default: false

      t.timestamps null: false
    end
  end
end
