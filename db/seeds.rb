# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Seeding assets..."

admin = User.find_or_create_by!(email: 'jondoe@phoenix-realestate.com') do  |user|
    user.first_name = 'jon'
    user.last_name = 'doe'
    user.password = 'chemistry'
    user.phone_no = '07064334160'
    user.role = 'admin'

end


# db/seeds.rb


assets =[
  {
    name: "Luxury Condo in Downtown",
    address: "123 Main St, New York, NY",
    tenure: "Freehold",
    sale_type: "For Sale",
    area: "1200 sq ft",
    number_of_bedrooms: 2,
    number_of_bathrooms: 2,
    price: 950000.00,
    images: "luxury_condo.jpg",
    status: "active",
    asset_category: "Real Estate",
    city: 1
  },
  {
    name: "Family Home in Suburbs",
    address: "456 Elm St, Los Angeles, CA",
    tenure: "Leasehold",
    sale_type: "For Rent",
    area: "2000 sq ft",
    number_of_bedrooms: 4,
    number_of_bathrooms: 3,
    price: 3500.00,
    images: "family_home.jpg",
    status: "active",
    asset_category: "Real Estate",
    city: 2
  },
  {
    name: "Beachfront Villa",
    address: "789 Ocean Dr, Miami, FL",
    tenure: "Freehold",
    sale_type: "For Sale",
    area: "3500 sq ft",
    number_of_bedrooms: 5,
    number_of_bathrooms: 4,
    price: 2500000.00,
    images: "beachfront_villa.jpg",
    status: "inactive",
    asset_category: "Real Estate",
    city: 3
  },
  {
    name: "Modern Apartment",
    address: "321 Market St, San Francisco, CA",
    tenure: "Leasehold",
    sale_type: "For Rent",
    area: "800 sq ft",
    number_of_bedrooms: 1,
    number_of_bathrooms: 1,
    price: 2800.00,
    images: "modern_apartment.jpg",
    status: "active",
    asset_category: "Real Estate",
    city: 4
  },
  {
    name: "Countryside Cottage",
    address: "654 Green Ln, Austin, TX",
    tenure: "Freehold",
    sale_type: "For Sale",
    area: "1500 sq ft",
    number_of_bedrooms: 3,
    number_of_bathrooms: 2,
    price: 450000.00,
    images: "countryside_cottage.jpg",
    status: "inactive",
    asset_category: "Real Estate",
    city: 5
  },
  {
    name: "Penthouse Suite",
    address: "987 Skyline Rd, Chicago, IL",
    tenure: "Leasehold",
    sale_type: "For Rent",
    area: "2500 sq ft",
    number_of_bedrooms: 3,
    number_of_bathrooms: 3,
    price: 12000.00,
    images: "penthouse_suite.jpg",
    status: "active",
    asset_category: "Real Estate",
    city: 4
  }
]

assets.each do |asset_data|
    Asset.find_or_create_by!(name: asset_data[:name]) do |asset|
     asset.assign_attributes(asset_data)
    end
end

puts "Assets seeded successfully!"
