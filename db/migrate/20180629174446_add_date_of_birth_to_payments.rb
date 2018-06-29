class AddDateOfBirthToPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :date_of_birth, :date
  end
end
