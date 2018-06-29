class RemoveTokenFromPayments < ActiveRecord::Migration[5.1]
  def change
    remove_column :payments, :token
  end
end
