class ChangeHasIcpeInBusinessAssetsTable < ActiveRecord::Migration[5.2]
  def change
    change_column :business_assets, :has_icpe, :boolean, using: 'case when has_icpe = 0 then false else true end'
  end
end
