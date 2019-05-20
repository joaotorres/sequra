class Shopper < ApplicationRecord
  has_many :orders, dependent: :destroy
end
