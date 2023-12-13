class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :phone_no, :role, :total_asset, :total_earnings, :net_earnings
  has_many :portfolios
  has_one :wallet
  has_many :assets
  has_one :earning
end
