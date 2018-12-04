class GeographicalLocation < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_one :business_asset
  has_one :interest
end
