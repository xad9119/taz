class Transaction < ApplicationRecord
  belongs_to :business_asset
  belongs_to :buyer, class_name: "Company"
  belongs_to :seller, class_name: "Company"
  validates :date, presence: true
  validates :price, presence: true

  def ranked_comparables
    filtered_comparables.sort_by { |c| distance_to(c) }
  end

  def fair_price(comparables)
    sum = 0
    comparables.each do |t|
      sum += (t.price + 0.0) / (t.business_asset.surface)
    end
    average = !comparables.empty? ? sum / comparables.count : 0
    return average * business_asset.surface
  end

  def define_attributes(my_hash, business_asset)
    buyer_name = my_hash['buyer_name'] if !my_hash['buyer_name'].empty?
    buyer = Company.find_by(name: buyer_name)

    if buyer.nil? && !buyer_name.nil?
      buyer = Company.new(name: buyer_name)
      buyer.save!
    end

    seller_name = my_hash['seller_name'] if !my_hash['seller_name'].empty?

    seller = Company.find_by(name: seller_name)
    if seller.nil? && !seller_name.nil?
      seller = Company.new(name: seller_name)
      seller.save!
    end


    self.buyer = buyer
    self.seller = seller
    self.date = my_hash['date'].to_date
    self.price = my_hash['price'].to_f

  end

  private

  def filtered_comparables
    Transaction.all
               .select { |t| filtered_absolute_conditions(t) }
               .select { |t| t.business_asset.asset_type == business_asset.asset_type }
  end

  def filtered_absolute_conditions(transaction)
    condition0 = transaction.id != id
    condition1 = transaction.price > 0
    condition2 = transaction.business_asset.surface ? transaction.business_asset.surface > 0 : false
    condition3 = transaction.business_asset.current_rental ? transaction.business_asset.current_rental.annual_rent > 0 : false
    condition4 = transaction.business_asset.geographical_location.latitude
    condition5 = transaction.business_asset.geographical_location.longitude
    return condition0 && condition1 && condition2 && condition3 && condition4 && condition5
  end

  def distance_to(transaction)
    loc1 = [transaction.business_asset.geographical_location.latitude, transaction.business_asset.geographical_location.longitude]
    loc2 = [business_asset.geographical_location.latitude, business_asset.geographical_location.longitude]

    rad_per_deg = Math::PI/180  # PI / 180
    rkm = 6371                  # Earth radius in kilometers
    rm = rkm * 1000             # Radius in meters

    dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
    dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg

    lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }

    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    rm * c # Delta in meters
  end
end
