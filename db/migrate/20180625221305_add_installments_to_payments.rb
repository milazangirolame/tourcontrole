class AddInstallmentsToPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :installments, :integer
  end
end
