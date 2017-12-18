
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#
# class CreateProperties < ActiveRecord::Migration[5.1]
#   def change
#     create_table :properties do |t|
#       t.text :address
#       t.integer :landsize
#       t.integer :bedrooms
#       t.float :bathrooms
#       t.boolean :privateparking
#       t.bigint :expected_price
#       t.timestamps
#     end
#   end
# end

# class CreateUsers < ActiveRecord::Migration[5.1]
#   def change
#     create_table :users do |t|
#       t.text :name
#       t.text :email
#       t.date :dob
#       t.string :password_digest
#       t.boolean :admin, :default=>false
#       t.timestamps
#     end
#   end
# end

Property.destroy_all
p1 = Property.create :address => '1 George Street, Sydney NSW 2000', :suburb => 'Sydney', :landsize => 500, :bedrooms => 5, :bathrooms => 2.5, :private_parking => 'true', :expected_price => 555000
p2 = Property.create :address => '1 Pitt Street, Sydney NSW 2000', :suburb => 'Sydney', :landsize => 600, :bedrooms => 4, :bathrooms => 2.2, :private_parking => 'true', :expected_price => 855000
p3 = Property.create :address => '1 Elizabeth Street, Sydney NSW 2000', :suburb => 'Sydney', :landsize => 700, :bedrooms => 3, :bathrooms => 4.5, :private_parking => 'true', :expected_price => 1555000
p4 = Property.create :address => '1 York Street, Sydney NSW 2000', :suburb => 'Sydney', :landsize => 800, :bedrooms => 2, :bathrooms => 1.5, :private_parking => 'true', :expected_price => 2555000

User.destroy_all
u1 = User.create :name =>'Bing',:email =>'hb@ga.co', :dob => 20000101,:password => 'chicken',:admin => true
u2 = User.create :name =>'Tom', :email => 'tom@ga.co',:dob =>20000406, :password => 'chicken'
