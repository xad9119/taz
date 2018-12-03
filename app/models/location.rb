class Location < ApplicationRecord
  validates :latitude presence: true
  validates :longitude presence: true
  has_many :assets
  has_many :interests
end
