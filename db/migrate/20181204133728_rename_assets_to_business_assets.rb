class RenameAssetsToBusinessAssets < ActiveRecord::Migration[5.2]
  def change
    rename_table :assets, :business_assets
  end
end
