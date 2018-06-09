class AddCoordinatesToTourStores < ActiveRecord::Migration[5.1]
  def change
    add_column :tour_stores, :latitude, :float
    add_column :tour_stores, :longitude, :float
  end
end
