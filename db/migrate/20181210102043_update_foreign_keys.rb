class UpdateForeignKeys < ActiveRecord::Migration[5.2]
  def change
  remove_foreign_key :attachments, :business_assets
  add_foreign_key :attachments, :business_assets, on_delete: :cascade

  end
end
