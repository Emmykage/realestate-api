class Asset < ApplicationRecord
    has_many_attached :photos
    has_rich_text :description_body
    has_many :portfolios, dependent: :delete_all
    enum :asset_category, {"Studio Apartment" => 1, "Family Home" => 0, "Condo & Villa" => 2, "Water Front Home" => 3, "Real Estate" => 4}
    enum :city, {"United Kingdom" => 0, "Spain" => 1, "Dubai"=> 2, "Berlin" => 3, "Tokyo" => 4, "Shangai" => 5}

    validates :price, presence: true

    def images_url
        photos.map do |photo|
        Rails.application.routes.url_helpers.url_for(photo)
        end if photos.attached?
    end

end