require 'csv'

[Merchant, Shopper, Order].each { |m| m.destroy_all }

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

p 'Loading Merchants'
merchants = CSV.read('db/seed_record_files/merchants.csv')
merchants.each do |m|
  Merchant.create!(id: m[0].to_i, name: m[1], email: m[2], cif: m[3])
end

p 'Loading Shoppers'
shoppers = CSV.read('db/seed_record_files/shoppers.csv')
shoppers.each do |s|
  Shopper.create!(id: s[0].to_i, name: s[1], email: s[2], nif: s[3])
end

p 'Loading Orders'
orders = CSV.read('db/seed_record_files/orders.csv')
orders.each do |o|
  completed_at = o[4].present? ? DateTime.parse(o[4]) : nil

  Order.create!(
    id: o[0].to_i,
    merchant_id: o[1],
    shopper_id: o[2],
    amount_cents: o[3].gsub('.','').to_i,
    created_at: DateTime.parse(o[4]),
    completed_at: completed_at
  )
end