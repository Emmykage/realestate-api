class AssetSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :tenure, :sale_type, :area, :number_of_bedrooms, :number_of_bathrooms, :price, :status, :city, :images_url, :asset_description, :portfolios, :features, :property_type
  has_many :portfolios
end