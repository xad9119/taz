class BusinessAsset < ApplicationRecord
  belongs_to :user
  belongs_to :geographical_location
  has_many :transactions
  has_many :rentals
  has_many :attachments
  belongs_to :business_asset_manager, class_name: "Company"
end
