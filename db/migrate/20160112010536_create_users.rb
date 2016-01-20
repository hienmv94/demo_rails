class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.timestamps null: false
      t.string :remember_digest
      t.boolean :admin, default: false
      t.string :activation_digest
      t.boolean :activated, default: false
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.datetime :activated_at
    end
    add_index :users, [:email]
     # add_index :statistics, [:name, :item_i]
  end
end
