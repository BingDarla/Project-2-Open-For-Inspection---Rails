class CreateAuctions < ActiveRecord::Migration[5.1]
  def change
    create_table :auctions do |t|
      t.integer :property_id
      t.integer :user_id
      t.integer :price
      t.timestamps
    end
  end
end
