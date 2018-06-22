class RenameContryCode < ActiveRecord::Migration[5.1]
  def change
    rename_column :payments, :phone_contry_code, :phone_country_code
  end
end
