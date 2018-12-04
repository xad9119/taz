class Interest < ApplicationRecord
  belongs_to :location
  validates :type, presence: true
  validates :description, presence: true
end
