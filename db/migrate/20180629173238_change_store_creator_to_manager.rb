class ChangeStoreCreatorToManager < ActiveRecord::Migration[5.1]
  def change
    rename_column :tour_store_admins, :store_creator, :manager
  end
end
