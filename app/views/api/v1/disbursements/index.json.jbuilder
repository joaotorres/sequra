json.array! @disbursements do |disbursement|
  json.merchant_id disbursement.merchant_id
  json.amount humanized_money(disbursement.amount)
end