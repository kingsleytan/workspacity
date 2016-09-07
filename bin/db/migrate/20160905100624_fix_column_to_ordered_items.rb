class FixColumnToOrderedItems < ActiveRecord::Migration[5.0]
  def change
    rename_column :ordered_items, :item_id, :package_id
  end
end
