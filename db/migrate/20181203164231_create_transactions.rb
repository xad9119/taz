class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :asset, foreign_key: true
      t.integer :buyer_id
      t.integer :seller_id
      t.numeric :price
      t.date :date

      t.timestamps
    end
  end
end
