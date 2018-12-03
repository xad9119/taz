class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.references :asset, foreign_key: true
      t.string :type
      t.string :url

      t.timestamps
    end
  end
end
