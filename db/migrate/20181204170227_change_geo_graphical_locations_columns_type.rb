class ChangeGeoGraphicalLocationsColumnsType < ActiveRecord::Migration[5.2]
  def change
    change_column :geographical_locations, :latitude, :float
    change_column :geographical_locations, :longitude, :float
  end
end
