class RenameTourStoreAddressFields < ActiveRecord::Migration[5.1]
  def change
    rename_column :tour_stores, :address, :street_name
    rename_column :tour_stores, :street, :street_number
    rename_column :tour_stores, :street_address, :neighborhood
  end
end
