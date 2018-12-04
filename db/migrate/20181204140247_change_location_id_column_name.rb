class ChangeLocationIdColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :business_assets, :location_id, :geographical_location_id
    rename_column :interests, :location_id, :geographical_location_id
  end
end
