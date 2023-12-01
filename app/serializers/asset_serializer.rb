class AssetSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :tenure, :sale_type, :area, :number_of_bedrooms, :number_of_bathrooms, :price, :images, :status, :city, :image_url, :portfolios
  has_many :portfolios
end
