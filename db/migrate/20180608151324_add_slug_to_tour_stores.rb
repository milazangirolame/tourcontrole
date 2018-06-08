class AddSlugToTourStores < ActiveRecord::Migration[5.1]
  def change
    add_column :tour_stores, :slug, :string
  end
end
