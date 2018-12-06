class Transaction < ApplicationRecord
  belongs_to :business_asset
  belongs_to :buyer, class_name: "Company"
  belongs_to :seller, class_name: "Company"
  validates :date, presence: true
  validates :price, presence: true

  def ranked_comparables
    filtered_comparables.sort_by { |c| distance_to(c) }
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
    condition0 = transaction.id != seld.id
    condition1 = transaction.price > 0
    condition2 = transaction.business_asset.surface > 0
    condition3 = transaction.business_asset.current_rental.annual_rent > 0
    condition4 = transaction.business_asset.geographical_location.latitude > 0
    condition5 = transaction.business_asset.geographical_location.longitude > 0
    return condition0 && condition1 && condition2 && condition3 && condition4 && condition5
  end

  def distance_to(transaction)
    point1 = transaction.geographical_location
    point2 = geographical_location

    # convert to coordinate arrays
    point1 = extract_coordinates(point1)
    point2 = extract_coordinates(point2)

    # convert degrees to radians
    point1 = to_radians(point1)
    point2 = to_radians(point2)

    # compute deltas
    dlat = point2[0] - point1[0]
    dlon = point2[1] - point1[1]

    a = Math.sin(dlat / 2)**2 + Math.cos(point1[0]) * Math.sin(dlon / 2)**2 * Math.cos(point2[0])
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
    c * earth_radius(options[:units])
  end 
end
