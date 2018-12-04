class ChangeAssetIdColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :rentals, :asset_id, :business_asset_id
    rename_column :transactions, :asset_id, :business_asset_id
    rename_column :attachments, :asset_id, :business_asset_id
  end
end
