class Rental < ApplicationRecord
  belongs_to :asset
  belongs_to :tenant, class_name: "Company"

  validates :start_date, presence: true
  validates :end_date, presence: true

  validates :break_date_1, presence: true
  validates :annual_rent, presence: true
end
