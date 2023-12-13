class User < ApplicationRecord
    has_secure_password
    has_one :wallet
    has_one :earning
    has_many :portfolios
    has_many :blogs
    has_many :assets, through: :portfolios
    has_many :portfolio_interest, through: :portfolios


    enum :role, {client: 0, admin: 1}

    validates :email, :first_name, :last_name, presence: true
    validates :email, uniqueness: { case_sensitive: false }
    validates :password, length: { in: 6..20 }
    validates :email, uniqueness: true, format: { with: /\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,})+\z/i, message: ":Please enter a valid email address."}

    def total_asset
        # portfolios.collect{|portfolio| portfolio.valid? ? portfolio.amount : 0}.sum
        if assets.any?
        assets.collect{|asset| asset.valid? ? asset.price : 0}.sum
        else
            0.0
        end
    end

    def total_earnings
        # portfolios.collect{|portfolio| portfolio.valid? ? portfolio.amount : 0}.sum
        if portfolios.any?
        portfolios.collect{|portfolio| portfolio.valid? ? portfolio.investment_interest : 0}.sum
        else
            0.0
        end
    end

    def net_earnings 
        total_earnings - earning.withdraw_earning
    end

    def withdrawable_funds
        net_earnings + wallet.wallet_balance
      
    end
end
