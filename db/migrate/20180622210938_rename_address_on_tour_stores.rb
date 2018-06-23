class RenameAddressOnTourStores < ActiveRecord::Migration[5.1]
  def change
    rename_column :tour_stores, :address, :form_address
  end
end
