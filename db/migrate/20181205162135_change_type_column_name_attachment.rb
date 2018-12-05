class ChangeTypeColumnNameAttachment < ActiveRecord::Migration[5.2]
  def change
    rename_column :attachments, :type, :attachment_type
  end
end
