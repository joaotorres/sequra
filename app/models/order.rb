class Order < ApplicationRecord
  belongs_to :merchant
  belongs_to :shopper

  monetize :amount_cents
end
