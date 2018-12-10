class AddPictogramToAssetCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :asset_categories, :pictogram, :string
  end
end
