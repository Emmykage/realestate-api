class EarningTransaction < ApplicationRecord
  belongs_to :earning
  before_create :valid_transaction?

  # validate :valid_transaction_amount


  def valid_transaction?

    raise ActiveRecord::RecordNotSaved, "You have limited funds"  unless  ((earning.net_earnings * (246 * 16)) - amount ) >= 0
    true
    
  end
  # def valid_transaction_amount
   
  #   if amount > earning.net_earnings * 246 * 16
  #     errors.add(:base, "Insufficient funds for withdrawal")
  #   elsif amount <= 0
  #     errors.add(:amount, "Amount must be greater than zero")
  #   end
  # end
end
