p "----------- Destroying everything -----------"
Rental.destroy_all
Transaction.destroy_all
Attachment.destroy_all
BusinessAsset.destroy_all
GeographicalLocation.destroy_all
Company.destroy_all
User.destroy_all



p "----------- Creating Users -----------"
users_array = [
  {
    first_name: "Sid",
    last_name: "Iceage",
    email: "sid@braxton.am",
    password: "azerty1",
    job_title: "asset_manager"
  }
]

User.create!(users_array)

p "----------- Creating Companies -----------"
companies_array = [
  {
    name: "braxton am",
    credit_rating: "good"
  },
  {
    name: "Evil Corp",
    credit_rating: "good"
  },
  {
    name: "Bank of Evil"
  },
  {
    name: "Dummy and Sons",
    credit_rating: "horrible"
  }
]

Company.create!(companies_array)

p "----------- Creating Locations -----------"
geographical_locations_array = [
  {
    address: "16 villa gaudelet, Paris, 75011"
  },
  {
    address: "204 rond point du pont de sèvres, Paris, 92100"
  },
  {
    address: "1 avenue des champs élysées, Paris, 75008"
  }
]
GeographicalLocation.create!(geographical_locations_array)

p "----------- Creating Asset Categories -----------"
  asset_categories_array = ["stock warehouse", "logistics warehouse", "shop", "office"]
  asset_categories_array.each {|a| AssetCategory.create!(name: a)}


p "----------- Creating Assets -----------"

business_assets_array = [
  {
    user: User.first,
    business_asset_manager: Company.first,
    geographical_location: GeographicalLocation.first,
    construction_year: 2001,
    asset_type: "Logements",
    occupancy_rate: 0.45,
    office_area_share: 0.33,
    potential_annual_rent: 100000,
    potential_annual_rent_sqm: 1000,
    surface: 100,
    general_condition: "gros travaux à effectuer"
  }
]
BusinessAsset.create!(business_assets_array)


p "----------- Creating Transactions -----------"
transaction_array = [
  {
    business_asset: BusinessAsset.first,
    buyer: Company.first,
    seller: Company.first,
    price: 1000,
    date: Date.today()
  }
]

Transaction.create!(transaction_array)



p "----------- Creating Business Assets Categories -----------"


asset_categories_array = [
  "Stock warehouse",
  "logistics warehouse",
  "Retail",
  "Office",
  "HousiNg",
  "lIght Industrial",
  "hotel",
  "Industrial"
]

asset_categories_array.map! {|x| x.capitalize}



asset_categories_array.each do |a|
  AssetCategory.create!(
    name: a,
    pictogram: 'fas fa-warehouse'
    )
end



p "----------- Seeding from CSV -----------"

i = 1

filepath = File.join(Rails.root, "db", "seed_taz_c.csv")
csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }

CSV.foreach(filepath, csv_options) do |row|

  p "----------- Created #{i} entries from CSV -----------" if i%10 == 0
  i += 1

  row = row.to_h.symbolize_keys

  row_loc = row.select{ |key, _| GeographicalLocation.attribute_names.index(key.to_s) }
  location = GeographicalLocation.new(row_loc)
  location.address = "#{location.address.strip if location.address}, #{row[:ville].strip if row[:ville]}, #{row[:code_postal].strip if row[:code_postal] }"
  location.save!

  row_asset = row.select{ |key, _| BusinessAsset.attribute_names.index(key.to_s) }
  asset = BusinessAsset.new(row_asset)
  asset.geographical_location = location
  asset.user = User.first
  asset.business_asset_manager = Company.first
  asset.save!

  tenant = Company.new(name: row[:name_rent])
  tenant.name = "placeholder" unless tenant.name
  tenant.save!

  row_rental = row.select{ |key, _| Rental.attribute_names.index(key.to_s) }
  rental = Rental.new(row_rental)
  rental.business_asset = asset
  rental.tenant = tenant
  rental.annual_rent = 0 unless rental.annual_rent
  rental.start_date = DateTime.new(2000)
  rental.break_date_1 = DateTime.new(2020)
  rental.end_date = DateTime.new(2020)
  rental.save!

  owner = Company.new(name: row[:name_owner])
  owner.name = "placeholder" unless owner.name
  owner.save!

  row_tr = row.select{ |key, _| Transaction.attribute_names.index(key.to_s) }
  transaction = Transaction.new(row_tr)
  transaction.business_asset = asset
  transaction.seller = Company.first
  transaction.buyer = owner
  transaction.date = DateTime.new(1000) unless transaction.date
  transaction.price = 0 unless transaction.price
  transaction.save!

end


p "----------- Creating Attachments -----------"
BusinessAsset.all.each_with_index do |b, i|
  a = Attachment.new
  a.business_asset = b
  a.attachment_type = 'photo'
  loc = b.geographical_location
  url = "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=#{loc.latitude},#{loc.longitude}&fov=90&heading=235&pitch=10&key=#{ENV['GOOGLE_API_BROWSER_KEY']}"
  a.url = url
  a.remote_file_url = url
  a.save!
  p "#{i} / #{BusinessAsset.all.count}"
end
