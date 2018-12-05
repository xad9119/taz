class Attachment < ApplicationRecord
  belongs_to :business_asset
  validates :url, presence: true
end
