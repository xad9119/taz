class AddFileToAttachments < ActiveRecord::Migration[5.2]
  def change
    add_column :attachments, :file, :string
  end
end
