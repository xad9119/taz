p "----------- Destroying everything -----------"
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
    latitude: 48.92446,
    longitude: 2.36016
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
    has_icpe: true,
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
