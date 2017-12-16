class CreateSolds < ActiveRecord::Migration[5.1]
  def change
    create_table :solds do |t|
      t.date :sold_date
      t.integer :sold_price
      t.integer :property_id
      t.timestamps
    end
  end
end
