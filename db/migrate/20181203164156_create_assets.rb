class CreateAssets < ActiveRecord::Migration[5.2]
  def change
    create_table :assets do |t|
      t.references :user, foreign_key: true
      t.references :location, foreign_key: true
      t.integer :asset_manager_id
      t.integer :construction_year
      t.integer :has_icpe
      t.text :type
      t.numeric :occupancy_rate
      t.numeric :office_area_share
      t.numeric :potential_annual_rent
      t.numeric :potential_annual_rent_sqm
      t.numeric :height
      t.numeric :land_surface
      t.numeric :surface
      t.text :general_condition
      t.text :description

      t.timestamps
    end
  end
end
