class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :phone_no, :total_asset
  has_many :portfolios
  has_one :wallet
  # has_many :assets
end
