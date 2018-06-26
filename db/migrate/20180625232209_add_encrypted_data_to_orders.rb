class AddEncryptedDataToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :encrypted_data, :string
  end
end
