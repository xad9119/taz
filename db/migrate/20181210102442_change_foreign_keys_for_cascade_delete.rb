class ChangeForeignKeysForCascadeDelete < ActiveRecord::Migration[5.2]
  def change
  remove_foreign_key :rentals, :business_assets
  add_foreign_key :rentals, :business_assets, on_delete: :cascade

  remove_foreign_key :transactions, :business_assets
  add_foreign_key :transactions, :business_assets, on_delete: :cascade

  remove_foreign_key :business_asset_categories, :business_assets
  add_foreign_key :business_asset_categories, :business_assets, on_delete: :cascade

  end
end
