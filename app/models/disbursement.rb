class Disbursement < ApplicationRecord
  belongs_to :merchant

  monetize :amount_cents
end
