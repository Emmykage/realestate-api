# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Seeding assets..."
puts "createing users"

admin = User.find_or_create_by!(email: 'jondoe@phoenix-realestate.com') do  |user|
    user.first_name = 'jon'
    user.last_name = 'doe'
    user.password = 'chemistry'
    user.phone_no = '07064334160'
    user.role = 'admin'
    user.skip_confirmation_notification! if user.respond_to?(:skip_confirmation_notification!)


end

client = User.find_or_create_by!(email: 'yankee@gmail.com') do  |user|
    user.first_name = 'yankee'
    user.last_name = 'doodoo'
    user.password = 'chemistry'
    user.phone_no = '07064334161'
    user.role = 'client'
    user.skip_confirmation_notification! if user.respond_to?(:skip_confirmation_notification!)


end


# db/seeds.rb


assets = [
    {
      name: "Luxury Condo in Downtown",
      address: "123 Main St, New York, NY",
      tenure: "Freehold",
      sale_type: "For Sale",
      area: "1200 sq ft",
      number_of_bedrooms: 2,
      number_of_bathrooms: 2,
      price: 950000.00,
      images: "https://images.unsplash.com/photo-1570129477492-45c003edd2be",
      status: "active",
      asset_category: "Real Estate",
      city: 1,
      asset_description: "A luxurious 2-bedroom condo located in the heart of downtown New York. Ideal for professionals seeking modern living in a prime location with access to shopping, dining, and public transportation."
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
      images: "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      status: "active",
      asset_category: "Real Estate",
      city: 2,
      asset_description: "Spacious 4-bedroom family home in a quiet suburban neighborhood. Perfect for growing families, with a large backyard, modern kitchen, and easy access to schools and parks."
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
      images: "https://plus.unsplash.com/premium_photo-1712083524480-b508a0e4f956?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      status: "inactive",
      asset_category: "Real Estate",
      city: 3,
      asset_description: "A stunning beachfront villa with 5 bedrooms and 4 bathrooms, offering spectacular ocean views. Perfect for those seeking a luxurious and private getaway in Miami."
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
      images: "https://images.unsplash.com/photo-1580587771525-78b9dba3b914",
      status: "active",
      asset_category: "Real Estate",
      city: 4,
      asset_description: "A sleek, modern 1-bedroom apartment located in the vibrant city center of San Francisco. Ideal for young professionals with a contemporary design and close to public transportation."
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
      images: "https://images.unsplash.com/photo-1416331108676-a22ccb276e35?q=80&w=1734&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      status: "inactive",
      asset_category: "Real Estate",
      city: 5,
      asset_description: "A charming 3-bedroom cottage located in the countryside near Austin. Perfect for those seeking tranquility, with a large garden and picturesque views of rolling hills."
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
      images: "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688",
      status: "active",
      asset_category: "Real Estate",
      city: 5,
      asset_description: "Exclusive 3-bedroom penthouse suite with breathtaking views of the Chicago skyline. Offers luxurious living with a modern kitchen, private balcony, and high-end finishes."
    }
  ]

puts "createing assets"


assets.each do |asset_data|
    Asset.find_or_create_by!(name: asset_data[:name]) do |asset|
     asset.assign_attributes(asset_data)
    end
end

puts "Assets seeded successfully!"
