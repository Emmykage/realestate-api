class User < ApplicationRecord
    has_secure_password
    has_one :wallet
    has_one :earning
    has_many :portfolios
    has_many :blogs
    has_many :earning_transactions, through: :earning
    has_many :assets, through: :portfolios
    has_many :portfolio_interests, through: :portfolios

    before_create :generate_confirmation_token 
    after_create :send_confirmation_email


    enum :role, {client: 0, admin: 1}

    validates :email, :first_name, :last_name, presence: true
    validates :email, uniqueness: { case_sensitive: false }
    validates :password, length: { in: 6..20 } #, on: :create
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
        earning.net_earnings
        # 0.0
    end
    def confirmed?
        confirmed_at.present?      
    end
 
  
    def generate_reset_password_token 
        self.reset_password_token = SecureRandom.hex(10)
        self.reset_password_sent_at = Time.current
    #   binding.b
    end
    def email_confirmation
        self.confirmed_at = Time.now 
        self.confirmation_token = nil
      save!
    end
    
    private 

    def generate_confirmation_token 
        self.confirmation_token = SecureRandom.hex(10)
        # self.confirmation_token =  SecureRandom.urlsafe_base64 
        self.confirmation_sent_at = Time.now
            
    end

    def send_confirmation_email 
        SendConfirmationInstructionJob.perform_now(self)
        # SendConfirmationInstructionJob
      
    end



end