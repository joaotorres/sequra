class Merchant < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :disbursements, dependent: :destroy
end
