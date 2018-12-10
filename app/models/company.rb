class Company < ApplicationRecord
  has_many :business_assets
  has_many :bought_transactions, class_name: "Transaction", foreign_key: :buyer_id
  has_many :sold_transactions,   class_name: "Transaction", foreign_key: :seller_id
  has_many :rentals
  validates :name, presence: true
end
