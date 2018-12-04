class Company < ApplicationRecord
  has_many :business_assets
  has_many :transactions
  has_many :rentals
  validates :name, presence: true
end
