class Wallet < ApplicationRecord
  belongs_to :user
  has_many :transactions, class_name: "transaction", foreign_key: "reference_id"
end
