class AccountProfile < ApplicationRecord
    validates :name, :address, :account_type, presence: true
    enum :account_type, {bank: 0, crypto: 1}
    default_scope {order(created_at: :desc)}

end
