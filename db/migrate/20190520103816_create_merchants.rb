class CreateMerchants < ActiveRecord::Migration[5.2]
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :email
      t.string :cif

      t.timestamps
    end
  end
end
