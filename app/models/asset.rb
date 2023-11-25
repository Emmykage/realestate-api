class Asset < ApplicationRecord
    has_one_attached :image
    has_many :portfolios, dependent: :delete_all
    enum :asset_category, {"Studio Apartment" => 1, "Family Home" => 0, "Condo & Villa" => 2, "Water Front Home" => 3, "Cozy Home" => 4}
    enum :city, {"United Kingdom" => 0, "Spain" => 1, "Dubai"=> 2, "Berlin" => 3, "Tokyo" => 4, "Shangai" => 5}

    validates :price, presence: true   

    def image_url 
        Rails.application.routes.url_helpers.url_for(image) if image.attached?
    end
    
end