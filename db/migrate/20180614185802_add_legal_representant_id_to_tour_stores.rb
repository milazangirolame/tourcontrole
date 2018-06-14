class AddLegalRepresentantIdToTourStores < ActiveRecord::Migration[5.1]
  def change
    add_column :tour_stores, :legal_representant_id, :string
  end
end
