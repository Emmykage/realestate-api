class UserSerializer < ActiveModel::Serializer
  attributes :id, :admin, :first_name, :last_name, :email, :phone_no, :role, :total_asset, :total_earnings, :total_investment, :net_earnings, :confirmed?
  has_many :portfolios
  has_one :wallet
  has_one :earning
  has_one :profile
end