class Wallet < ApplicationRecord
  belongs_to :user
  has_many :transactions


  def deposit
    if transactions.where(transaction_type: "deposit").any?
      transactions.where(status: "completed").collect{|transaction| transaction.amount}.sum 
    else 
      0.0

    end
    
  end

  def withdrawal 
    if transactions.where(transaction_type: "withdraw").any?
      transactions.where(transaction_type: "withdraw").collect{|transaction| transaction.amount}.sum 
    else 
      0.0
    end
  end

  def wallet_balance
    
    (user.net_earnings + deposit) - (withdrawal + user.total_asset)
   
  end

  
  # binding.b
  
end
