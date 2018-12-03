class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.references :asset, foreign_key: true
      t.integer :tenant_id
      t.numeric :annual_rent
      t.numeric :annual_rent_sqm
      t.date :start_date
      t.date :end_date
      t.date :break_date_1
      t.string :break_date_2
      t.date :break_date_3

      t.timestamps
    end
  end
end
