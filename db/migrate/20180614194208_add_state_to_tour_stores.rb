class AddStateToTourStores < ActiveRecord::Migration[5.1]
  def change
    add_column :tour_stores, :state, :string
  end
end
