class CreateShoppers < ActiveRecord::Migration[5.2]
  def change
    create_table :shoppers do |t|
      t.string :name
      t.string :email
      t.string :nif

      t.timestamps
    end
  end
end
