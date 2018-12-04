class Transaction < ApplicationRecord
  belongs_to :business_asset
  belongs_to :buyer, class_name: "Company"
  belongs_to :seller, class_name: "Company"
  validates :date, presence: true
  validates :price, presence: true
end
