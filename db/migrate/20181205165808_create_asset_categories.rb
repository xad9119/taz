class CreateAssetCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :asset_categories do |t|
      t.string :name
      t.string :picture
      t.timestamps
    end
  end
end
