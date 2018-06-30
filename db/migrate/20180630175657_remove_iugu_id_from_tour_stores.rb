class RemoveIuguIdFromTourStores < ActiveRecord::Migration[5.1]
  def change
    remove_column :tour_stores, :iugu_account_id
  end
end
