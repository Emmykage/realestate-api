class Investment < ApplicationRecord
    has_many :portfolios
    has_many :users, through: :portfolio
end
