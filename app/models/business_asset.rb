class BusinessAsset < ApplicationRecord
  belongs_to :user
  belongs_to :geographical_location
  has_many :transactions
  has_many :rentals
  has_many :attachments, dependent: :destroy
  has_many :asset_categories, through: :business_asset_categories
  belongs_to :business_asset_manager, class_name: "Company"
  accepts_nested_attributes_for :geographical_location
  BUSINESS_ASSET_TYPES = ["Stock warehouse", "Logistics warehouse", "Shop", "Office"]


  def current_rental
    unless self.rentals.empty?
      self.rentals.select { |r| !r.end_date || (r.start_date <= Date.today && Date.today <= r.end_date) }.first
    else
      nil
    end
  end

  def current_transaction
    unless self.transactions.empty?
      self.transactions.select {|r| r.date <= Date.today }.sort { |r| r.date }.last
    else
      nil
    end
  end

  def owner
    unless self.transactions.empty?
      self.transactions.select {|r| r.date <= Date.today }.sort { |r| r.date }.last.buyer
    else
      nil
    end
  end

  def seller
    unless self.transactions.empty?
      self.transactions.select {|r| r.date <= Date.today }.sort { |r| r.date }.last.seller
    else
      nil
    end
  end

  def tenant
    unless self.rentals.empty?
      self.rentals.select { |r| !r.end_date || (r.start_date <= Date.today && Date.today <= r.end_date) }.first.tenant
    else
      nil
    end
  end


  def define_attributes(my_hash, user)
    address = my_hash['geographical_location']['address'] if !my_hash['geographical_location']['address'].empty?
    geographical_location = GeographicalLocation.find_by(
      address: address)

    if geographical_location.nil? && !address.nil?
      geographical_location = GeographicalLocation.new(address: address)
      geographical_location.save!
    end

    asset_manager_name = my_hash['company']['name'] if !my_hash['company']['name'].empty?
    asset_manager = Company.find_by(name: asset_manager_name)
    if asset_manager.nil? && !asset_manager_name.nil?
      asset_manager = Company.new(name: asset_manager_name)
      asset_manager.save!
    end




    self.user = user
    self.geographical_location = geographical_location
    self.business_asset_manager = asset_manager
    self.surface = my_hash['surface'].gsub(/[^\d^\.]/, '').to_f if !my_hash['surface'].empty?
    self.land_surface = my_hash['land_surface'] if !my_hash['land_surface'].empty?
    self.construction_year = my_hash['construction_year'] if !my_hash['construction_year'].empty?
    self.height = my_hash['height'] if !my_hash['height'].empty?
    self.occupancy_rate = my_hash['occupancy_rate'] if !my_hash['occupancy_rate'].empty?
    self.office_area_share = my_hash['office_area_share'] if !my_hash['office_area_share'].empty?
    self.potential_annual_rent = my_hash['potential_annual_rent'].gsub(/[^\d^\.]/, '').to_f if !my_hash['potential_annual_rent'].empty?
    self.potential_annual_rent_sqm = compute_sqm_rent(self.potential_annual_rent, self.surface)

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
