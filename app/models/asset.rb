class Asset < ApplicationRecord
  belongs_to :user
  belongs_to :location
  has_many :transactions
  has_many :rentals
  has_many :attachments
  belongs_to :asset_manager, class_name: "Company"
end
