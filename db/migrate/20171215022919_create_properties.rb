class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.text :address
      t.integer :landsize
      t.integer :bedrooms
      t.float :bathrooms
      t.boolean :private_parking
      t.bigint :expectedPrice
      t.timestamps
    end
  end
end
