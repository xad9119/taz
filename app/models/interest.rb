class Interest < ApplicationRecord
  belongs_to :geographical_location
  validates :type, presence: true
  validates :description, presence: true
end
