class PortfolioInterestSerializer < ActiveModel::Serializer
  attributes :id, :interest
  has_one :portfolio
end
