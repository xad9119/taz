class RenameAssetManagerIdColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :business_assets, :asset_manager_id, :business_asset_manager_id
  end
end
