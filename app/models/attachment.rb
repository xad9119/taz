class Attachment < ApplicationRecord
  belongs_to :business_asset
  validates :type, presence: true
  validates :url, presence: true
end
