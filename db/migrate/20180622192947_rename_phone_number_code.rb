class RenamePhoneNumberCode < ActiveRecord::Migration[5.1]
  def change
    rename_column :payments, :phone_number_code, :phone_number
  end
end
