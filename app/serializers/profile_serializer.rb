class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :investment_purpose, :investment_property, :initial_investment, :investor_type
  has_one :user
end
