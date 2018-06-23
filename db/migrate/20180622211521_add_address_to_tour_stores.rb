class AddAddressToTourStores < ActiveRecord::Migration[5.1]
  def change
    add_column :tour_stores, :address, :string
    add_column :tour_stores, :street, :string
    add_column :tour_stores, :street_address, :string
    add_column :tour_stores, :full_address, :string
  end
end
