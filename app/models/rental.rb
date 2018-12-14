class Rental < ApplicationRecord
  belongs_to :business_asset
  belongs_to :tenant, class_name: "Company"
  validates :start_date, presence: true

  def define_attributes(my_hash, business_asset)
    tenant_name = my_hash['tenant_name'].empty? ? '-' : my_hash['tenant_name']
    tenant = Company.find_by(name: tenant_name)
    if tenant.nil? && !tenant_name.nil?
      tenant = Company.new(name: tenant_name)
      tenant.save!
    end
    start_date = my_hash['start_date'].empty? ? '2018-01-01'.to_date : my_hash['start_date'].to_date
    if my_hash['break_dates'] == "0"
      break_date_1 = start_date.nil? ? nil : start_date + 3.years
      break_date_2 = start_date.nil? ? nil : start_date + 6.years
      break_date_3 = start_date.nil? ? nil : start_date + 9.years
    else
      break_date_1 = my_hash['break_date_1'].to_date
      break_date_2 = my_hash['break_date_2'].to_date
      break_date_3 = my_hash['break_date_3'].to_date
    end

    self.tenant = tenant
    self.business_asset = business_asset
    self.start_date = start_date
    self.break_date_1 = break_date_1
    self.break_date_2 = break_date_2
    self.break_date_3 = break_date_3
    self.annual_rent = my_hash['annual_rent'].gsub(/[^\d^\.]/, '').to_f
    self.annual_rent_sqm = compute_sqm_rent(self.annual_rent, business_asset.surface)
  end

  private

  def compute_sqm_rent(rent, surface)
    unless rent.nil? || surface.nil? || surface.zero?
      rent / surface
    else
      nil
    end
  end
end
