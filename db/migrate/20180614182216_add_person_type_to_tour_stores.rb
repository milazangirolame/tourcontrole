class AddPersonTypeToTourStores < ActiveRecord::Migration[5.1]
  def change
    add_column :tour_stores, :person_type, :string
  end
end
