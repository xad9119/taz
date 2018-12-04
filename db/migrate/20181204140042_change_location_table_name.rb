class ChangeLocationTableName < ActiveRecord::Migration[5.2]
  def change
    rename_table :locations, :geographical_locations
  end
end
