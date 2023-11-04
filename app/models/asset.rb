class Asset < ApplicationRecord
    has_many :portfolios, class_name: "portfolios", foreign_key: "reference_id"
end
