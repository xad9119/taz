class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :companies, :credit_grade, :credit_rating
  end
end
