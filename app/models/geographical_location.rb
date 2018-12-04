class GeographicalLocation < ApplicationRecord
  validates :latitude, presence: true
  validates :longitude, presence: true
  has_many :business_assets
  has_many :interests
end
