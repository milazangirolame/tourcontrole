class AddStateCodeToTourStores < ActiveRecord::Migration[5.1]
  def change
    add_column :tour_stores, :state_code, :string
  end
end
