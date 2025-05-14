class AssetSerializer < ActiveModel::Serializer
  attributes :id, :name, :asset_category, :address, :tenure, :sale_type, :area, :number_of_bedrooms, :number_of_bathrooms, :price, :status, :city, :images_url, :asset_description, :features, :property_type, :description_body, :mainphoto

  def description_body
    object.description_body.to_s
  end

end