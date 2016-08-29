class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :pasword_digest
      t.string :image
      t.integer :role
      t.datetime :password_reset_at
      t.string :password_reset_token

      t.timestamps
    end
  end
end
