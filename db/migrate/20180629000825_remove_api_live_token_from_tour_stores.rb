class RemoveApiLiveTokenFromTourStores < ActiveRecord::Migration[5.1]
  def change
    remove_column :tour_stores, :api_live_token
    remove_column :tour_stores, :api_test_token
    remove_column :tour_stores, :api_user_token
  end
end
