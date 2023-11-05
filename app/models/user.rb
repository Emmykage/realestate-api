class User < ApplicationRecord
    has_secure_password
    has_one :wallet
    has_many :portfolios
end
