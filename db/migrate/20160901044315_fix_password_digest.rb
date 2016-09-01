class FixPasswordDigest < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :pasword_digest, :password_digest
  end
end
