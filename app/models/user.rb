class User < ApplicationRecord
    has_secure_password
    has_one :wallet
    has_many :portfolioss, class_name: "portfolios", foreign_key: "reference_id"

end
