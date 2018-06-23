class AddMoipIDtoTourStores < ActiveRecord::Migration[5.1]
  def change
    add_column :tour_stores, :moip_id, :string
    add_column :tour_stores, :moip_access_token, :string
    add_column :tour_stores, :moip_channel_id, :string
  end
end
