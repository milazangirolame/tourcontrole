class RemoveAvailableSpotsFromEvents < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :available_spots
  end
end
