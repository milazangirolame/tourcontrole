class RemovePriceFromActivities < ActiveRecord::Migration[5.1]
  def change
    remove_column :activities, :price
  end
end
