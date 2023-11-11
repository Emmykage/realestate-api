class Asset < ApplicationRecord
    has_many :portfolios
    enum :asset_category, {"Studio Apartment" => 1, "Family Home" => 0, "Condo & Villa" => 2, "Water Front Home" => 3, "Cozy Home" => 4}

    validates :price, presence: true
end
