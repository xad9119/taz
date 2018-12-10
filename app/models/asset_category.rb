class AssetCategory < ApplicationRecord
  has_many :business_assets, through: :business_asset_categories
  validates :name, presence: true, uniqueness: true
end
