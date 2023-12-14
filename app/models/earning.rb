class Earning < ApplicationRecord
  belongs_to :user
  has_many :earning_transactions

  
  def withdraw_earning
    if earning_transactions.any?
     earning_transactions.collect{|transaction| transaction.amount.nil? ? 0 : transaction.amount }.sum

    else
        0.0
    end
  
  end
  def net_earnings
    user.total_earnings - withdraw_earning
  end

end
