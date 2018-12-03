class Company < ApplicationRecord
  has_many :assets
  has_many :transactions
  has_many :rentals
  validates :name, presence: true
end
