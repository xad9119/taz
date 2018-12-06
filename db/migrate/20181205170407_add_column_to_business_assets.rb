class AddColumnToBusinessAssets < ActiveRecord::Migration[5.2]
  def change
    add_column :business_assets, :asset_category_id, :integer, foreign_key: true
  end
end
