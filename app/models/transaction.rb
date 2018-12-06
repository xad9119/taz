class Transaction < ApplicationRecord
  belongs_to :business_asset
  belongs_to :buyer, class_name: "Company"
  belongs_to :seller, class_name: "Company"
  validates :date, presence: true
  validates :price, presence: true
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
end
