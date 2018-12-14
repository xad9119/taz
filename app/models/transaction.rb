require 'csv'

class Transaction < ApplicationRecord
  belongs_to :business_asset
  belongs_to :buyer, class_name: "Company"
  belongs_to :seller, class_name: "Company"
  validates :date, presence: true
  validates :price, presence: true

  def ranked_comparables
    result = []
    if ENV['PRICE_PREDICTION_ENABLED'] && false # to be removed to enable python
      create_csvs
      generate_predictions

      filepath = File.join(Rails.root, "lib/python/data/python_predicted.csv")
      csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
      CSV.foreach(filepath, csv_options) do |row|
        result << Transaction.find(row[0].to_i)
      end
      result.shift
    else
      result = filtered_comparables.sort_by { |c| distance_to(c) }
    end

    return result
  end

  def fair_price(comparables)
    # if ENV['PRICE_PREDICTION_ENABLED']
      # to be called after ranked_comparables
    #   array = []
    #   filepath = File.join(Rails.root, "lib/python/data/python_predicted.csv")
    #   csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
    #   CSV.foreach(filepath, csv_options) do |row|
    #     array << row[1].to_f
    #   end
    #   result = array[0]
    # else
    sum = 0
    comparables.each do |t|
      sum += (t.price + 0.0) / (t.business_asset.surface)
    end
    result = !comparables.empty? ? sum / comparables.count : 0
    # end

    return result * business_asset.surface
  end

  def define_attributes(my_hash, business_asset)
    buyer_name = my_hash['buyer_name'].empty? ? '-' : my_hash['buyer_name']
    buyer = Company.find_by(name: buyer_name)

    if buyer.nil? && !buyer_name.nil?
      buyer = Company.new(name: buyer_name)
      buyer.save!
    end

    seller_name = my_hash['seller_name'].empty? ? '-' : my_hash['seller_name']

    seller = Company.find_by(name: seller_name)
    if seller.nil? && !seller_name.nil?
      seller = Company.new(name: seller_name)
      seller.save!
    end
    sell_date = my_hash['date'].empty? ? '2018-01-01'.to_date : my_hash['date'].to_date

    self.business_asset = business_asset
    self.buyer = buyer
    self.seller = seller
    self.date = sell_date
    self.price = my_hash['price'].empty? ? 0 : my_hash['price'].gsub(/[^\d^\.]/, '').to_f
  end

  def generate_predictions
    script_path = Rails.root.join("lib/python/price_train_predict.py")
    `python #{script_path}`
  end

  private

  def create_csvs
    csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
    filepath = File.join(Rails.root, "lib/python/data/python_training.csv")
    CSV.open(filepath, 'wb', csv_options) do |csv|
      csv << ['id', 'date', 'asset_type', 'surface', 'latitude', 'longitutde', 'pricesqm']
      Transaction.all.select { |t| filtered_absolute_conditions(t) }.each do |tr|
        csv << [tr.id,
                tr.date,
                tr.business_asset.asset_type,
                tr.business_asset.surface,
                tr.business_asset.geographical_location.latitude,
                tr.business_asset.geographical_location.longitude,
                tr.price / tr.business_asset.surface]
      end
    end

    csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
    filepath = File.join(Rails.root, "lib/python/data/python_to_predict.csv")
    CSV.open(filepath, 'wb', csv_options) do |csv|
      csv << ['id', 'date', 'asset_type', 'surface', 'latitude', 'longitutde']
      csv << [self.id,
              self.date,
              self.business_asset.asset_type,
              self.business_asset.surface,
              self.business_asset.geographical_location.latitude,
              self.business_asset.geographical_location.longitude]
    end
  end


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
