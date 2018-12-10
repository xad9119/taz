class BusinessAssetCategory < ApplicationRecord
  belongs_to :business_asset
  belongs_to :asset_category
end
