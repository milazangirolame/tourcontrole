class CreateTourStoreAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :tour_store_admins do |t|
      t.integer :tour_store_id
      t.integer :user_id

      t.timestamps
    end
  end
end
