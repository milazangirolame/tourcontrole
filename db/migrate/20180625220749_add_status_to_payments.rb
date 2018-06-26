class AddStatusToPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :status, :string
  end
end
