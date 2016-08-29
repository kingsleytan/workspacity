class CreatePackages < ActiveRecord::Migration[5.0]
  def change
    create_table :packages do |t|
      t.string :title
      t.string :description
      t.float :price
      t.string :location
      t.string :image
      t.integer :service_id
      t.integer :user_id

      t.timestamps
    end
  end
end
