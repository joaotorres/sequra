class CreateDisbursements < ActiveRecord::Migration[5.2]
  def change
    create_table :disbursements do |t|
      t.references :merchant, foreign_key: true
      t.monetize :amount, currency: { present: false }
      t.integer :week
      t.integer :year

      t.timestamps
    end
  end
end
