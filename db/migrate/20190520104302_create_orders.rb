class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :merchant, foreign_key: true
      t.references :shopper, foreign_key: true
      t.monetize :amount, currency: { present: false }
      t.timestamp :completed_at

      t.timestamps
    end
  end
end
