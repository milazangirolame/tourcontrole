class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.integer :max_spots
      t.string :departure_location
      t.date :date
      t.integer :price
      t.references :tour_store, foreign_key: true

      t.timestamps
    end
  end
end
