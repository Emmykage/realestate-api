class User < ApplicationRecord
    has_secure_password
    has_one :wallet
    has_many :portfolios
    has_many :assets, through: :portfolios


    enum :role, {client: 0, admin: 1}

    validates :email, :first_name, :last_name, presence: true
    validates :email, uniqueness: { case_sensitive: false }
    validates :password, length: { in: 6..20 }
    validates :email, uniqueness: true, format: { with: /\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,})+\z/i, message: ":Please enter a valid email address."}

    def total_asset
        portfolios.collect{|portfolio| portfolio.valid? ? portfolio.amount : 0}.sum
         
    end
end
