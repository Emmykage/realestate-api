class Asset < ApplicationRecord
    has_many_attached :photos
    has_rich_text :description_body
    enum :city, {"United Kingdom" => 0, "Spain" => 1, "Dubai"=> 2, "Berlin" => 3, "Tokyo" => 4, "Shangai" => 5}


    validates :price, presence: true


    def images_url
        return [] unless photos.attached?

        mainCover = photos.find {|photo| photo.filename == mainphoto}
        sortedPhotos =  if mainCover
                [mainCover] + ( photos - [mainCover])
            else
                sorted = [photos.first] + photos[1..]
            end

            sortedPhotos.map do |photo|
            Rails.application.routes.url_helpers.url_for(photo)
        end
    end


end