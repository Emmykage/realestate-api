class User < ApplicationRecord
    has_secure_password
    attr_accessor :confirm_password

    has_one :wallet, dependent: :destroy
    has_one :earning, dependent: :destroy
    has_one :profile, dependent: :destroy
    has_many :portfolios, dependent: :destroy
    has_many :blogs, dependent: :destroy
    has_many :earning_transactions, through: :earning
    has_many :portfolio_interests, through: :portfolios
    has_many :transactions, through: :wallet
    has_many :investments, through: :portfolios

    before_create :generate_confirmation_token

    accepts_nested_attributes_for :profile, allow_destroy: true
    after_create :create_portfolios
    after_create :initialize_wallet
    after_create :send_confirmation_email
    before_validation :downcase_fields

    enum :role, {client: 0, admin: 1}

    validates :email, :first_name, :last_name, presence: true
    validates :email, uniqueness: { case_sensitive: false }
    validates :password, length: { in: 6..20 }, if: :password_required?
    validates :email, uniqueness: true, format: { with: /\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,})+\z/i, message: ":Please enter a valid email address."}

    def total_asset
        0.0
    end

    def downcase_fields
    self.email = email.downcase if email.present?
    end


    def total_earnings
        portfolio_interests.joins(:portfolio).sum(:interest)
    end

    #    def total_earnings
    #     portfolio_interests.sum(:interest)
    # end

    #     def total_earnings
    #    portfolios.where(status: :active).joins(:portfolio_interests).sum("portfolio_interests.interest")
    #     end


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
        save

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
        UserMailer.confirmation_email(self).deliver_now
    end

    def password_required?
    new_record? || password.present?
    end

end