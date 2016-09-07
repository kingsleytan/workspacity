class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :body
      t.string :image
      t.integer :user_id
      t.integer :package_id

      t.timestamps
    end
  end
end
