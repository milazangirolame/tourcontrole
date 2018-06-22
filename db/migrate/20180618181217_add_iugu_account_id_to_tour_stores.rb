class AddIuguAccountIdToTourStores < ActiveRecord::Migration[5.1]
  def change
    add_column :tour_stores, :iugu_account_id, :string
    add_column :tour_stores, :api_live_token, :string
    add_column :tour_stores, :api_test_token, :string
    add_column :tour_stores, :api_user_token, :string
  end
end
