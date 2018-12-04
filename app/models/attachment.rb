class Attachment < ApplicationRecord
  belongs_to :asset
  validates :type, presence: true
  validates :url, presence: true
end
