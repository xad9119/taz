p "----------- Destroying everything -----------"
Rental.destroy_all
Transaction.destroy_all
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
    address: "16 villa gaudelet"
  },
  {
    address: "204 rond point du pont de sèvres"
  },
  {
    address: "1 avenue des champs élysées"
  }
]
GeographicalLocation.create!(geographical_locations_array)


p "----------- Creating Assets -----------"

business_assets_array = [
  {
    user: User.first,
    business_asset_manager: Company.first,
    geographical_location: GeographicalLocation.first,
    construction_year: 2001,
    asset_type: "wharehouse",
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

p "----------- Seeding from CSV -----------"

filepath = File.join(Rails.root, "db", "seed_taz_c.csv")
csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }

CSV.foreach(filepath, csv_options) do |row|
  row = row.to_h.symbolize_keys

  row_loc = row.select{ |x| GeographicalLocation.attribute_names.index(x) }
  location = GeographicalLocation.new(row_loc)
  location.save!

  row_asset = row.select{ |x| BusinessAsset.attribute_names.index(x) }
  asset = BusinessAsset.new(row_asset)
  asset.geographical_location = location
  asset.user = User.first
  asset.business_asset_manager = Company.first
  asset.save!

  tenant = Company.new(name: row[:name_rent])
  tenant.name = "placeholder" unless tenant.name
  tenant.save!

  row_rental = row.select{ |x| Rental.attribute_names.index(x) }
  rental = Rental.new(row_rental)
  rental.business_asset_id = asset.id
  rental.tenant = tenant
  rental.annual_rent = 0 unless rental.annual_rent
  rental.start_date = DateTime.new(2000)
  rental.break_date_1 = DateTime.new(2020)
  rental.end_date = DateTime.new(2020)
  rental.save!

  owner = Company.new(name: row[:name_owner])
  owner.name = "placeholder" unless owner.name
  owner.save!

  row_tr = row.select{ |x| Transaction.attribute_names.index(x) }
  transaction = Transaction.new(row_tr)
  transaction.business_asset = asset
  transaction.seller = owner
  transaction.buyer = Company.first
  transaction.date = DateTime.new(1000) unless transaction.date
  transaction.price = 0 unless transaction.price
  transaction.save!

end


p "----------- Creating Attachments -----------"

attachments_array = [
  {
    business_asset: BusinessAsset.first,
    attachmetype: "plan",
    url: "http/www.lequipe.fr",
  }
]

Attachment.create!(attachments_array)


