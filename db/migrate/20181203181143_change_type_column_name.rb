class ChangeTypeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :assets, :type, :asset_type
  end
end
