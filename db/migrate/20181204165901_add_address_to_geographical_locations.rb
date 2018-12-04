class AddAddressToGeographicalLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :geographical_locations, :address, :string
  end
end
