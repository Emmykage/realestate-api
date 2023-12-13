class EarningTransaction < ApplicationRecord
  belongs_to :earning

  # before_create :valid_transaction?

  def valid_transaction?
    raise ActiveRecord::RecordNotSaved, "You have limited funds"  unless amount > earning.withdraw_earning
    true    
  end
end
