class AccountProfile < ApplicationRecord
    validates :bank, :bitcoin, :ethereum, :usdt, presence: true
    default_scope {order(created_at: :desc)}

end
