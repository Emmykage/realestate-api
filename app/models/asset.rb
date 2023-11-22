class Asset < ApplicationRecord
    has_many :portfolios
    enum :asset_category, {"Studio Apartment" => 1, "Family Home" => 0, "Condo & Villa" => 2, "Water Front Home" => 3, "Cozy Home" => 4}
    enum :city, {"United Kingdome" => 0, "Spain" => 1, "Dubai"=> 2, "Berlin" => 3, "Tokyo" => 4, "Shangai" => 5}

    validates :price, presence: true

    
    
end
