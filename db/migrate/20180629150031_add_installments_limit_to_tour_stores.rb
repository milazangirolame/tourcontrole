class AddInstallmentsLimitToTourStores < ActiveRecord::Migration[5.1]
  def change
    add_column :tour_stores, :installments_limit, :integer, null: 12, default: 12
  end
end
