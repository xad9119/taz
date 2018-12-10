class CreateBusinessAssetCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :business_asset_categories do |t|
      t.references :business_asset, foreign_key: true
      t.references :asset_category, foreign_key: true

      t.timestamps
    end
  end
end
