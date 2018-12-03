class CreateInterests < ActiveRecord::Migration[5.2]
  def change
    create_table :interests do |t|
      t.references :location, foreign_key: true
      t.string :type
      t.text :desctription

      t.timestamps
    end
  end
end
