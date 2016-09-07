class FixPriceType < ActiveRecord::Migration[5.0]
  def up
    change_column :packages, :price, :decimal, precision: 8, scale: 2
  end

  def down
    change_column :packages, :price, :float
  end

end
