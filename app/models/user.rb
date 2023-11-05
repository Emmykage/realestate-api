class User < ApplicationRecord
    has_secure_password
    has_one :wallet
    has_many :portfolios, class_name: "portfolio", foreign_key: "reference_id"

end
