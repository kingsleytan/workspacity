class ChangeColumnNameInServices < ActiveRecord::Migration[5.0]
  def change
    rename_column :services, :type, :name
  end
end
