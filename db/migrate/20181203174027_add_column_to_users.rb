class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :job_title, :string
    add_column :users, :first_name, :string
    add_column :users, :first_last, :string
  end
end
