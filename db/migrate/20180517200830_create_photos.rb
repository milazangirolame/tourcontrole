class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.string :image
      t.integer :activity_id
      t.integer :tour_store_id

      t.timestamps
    end
  end
end
