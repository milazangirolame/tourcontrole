class AddCityTotourStores < ActiveRecord::Migration[5.1]
  def change
    add_column :tour_stores, :city, :string
    add_column :tour_stores, :postal_code, :string
    add_column :tour_stores, :country, :string
    add_column :tour_stores, :country_code, :string
  end
end
