class PortfolioInterestSerializer < ActiveModel::Serializer
  attributes :id, :interest, :created_at
  has_one :portfolio
end
