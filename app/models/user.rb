class User < ApplicationRecord
    has_secure_password
    has_one :wallet
    has_one :earning
    has_one :profile
    has_many :portfolios
    has_many :blogs, dependent: :destroy
    has_many :earning_transactions, through: :earning
    has_many :portfolio_interests, through: :portfolios
    has_many :transactions, through: :wallet
    has_many :investments, through: :portfolios

    before_create :generate_confirmation_token

    accepts_nested_attributes_for :profile, allow_destroy: true
    # after_create :send_confirmation_email
    after_create :create_portfolios
    after_create :initialize_wallet


    enum :role, {client: 0, admin: 1}

    validates :email, :first_name, :last_name, presence: true
    validates :email, uniqueness: { case_sensitive: false }
    validates :password, length: { in: 6..20 } #, on: :create
    validates :email, uniqueness: true, format: { with: /\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,})+\z/i, message: ":Please enter a valid email address."}

    def total_asset
        0.0
    end


    # def total_earnings
    #     portfolio_interests.joins(:portfolio).sum(:interest)
    # end

       def total_earnings
        portfolio_interests.sum(:interest)
    end


    def initialize_wallet
        create_wallet
    end





    def admin
        role  === "admin"
    end

    def create_portfolios
        Investment.all.each do |invest|
            portfolios.find_or_create_by!(investment_id: invest.id) do |portfolio|
                portfolio.portfolio_name = invest.name
            end
        end

    end

    def net_earnings

        0.0
    end
    def confirmed?
        confirmed_at.present?
    end

     def total_investment
            wallet&.calculated_investment || 0.0
            # 0.0
      end



    def generate_reset_password_token
        self.reset_password_token = SecureRandom.hex(10)
        self.reset_password_sent_at = Time.current

    end
    def email_confirmation
        self.confirmed_at = Time.now
        self.confirmation_token = nil
      save!
    end

    private

    def generate_confirmation_token
        self.confirmation_token = SecureRandom.hex(10)
        # self.confirmation_token = SecureRandom.urlsafe_base64
        self.confirmation_sent_at = Time.now

    end

    def send_confirmation_email
        SendConfirmationInstructionJob.perform_now(self)
        # SendConfirmationInstructionJob

    end



end