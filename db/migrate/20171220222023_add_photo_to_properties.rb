class AddPhotoToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :photo, :text 
  end
end
