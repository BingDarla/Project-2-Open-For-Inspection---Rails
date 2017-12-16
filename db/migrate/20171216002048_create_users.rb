class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.text :name
      t.text :email
      t.date :dob
      t.string :password_digest
      t.boolean :admin, :default=>false
      t.timestamps
    end
  end
end
