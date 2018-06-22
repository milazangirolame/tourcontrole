class AddCpfToPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :cpf, :string
    add_column :payments, :street, :string
    add_column :payments, :street_number, :string
    add_column :payments, :city, :string
    add_column :payments, :district, :string
    add_column :payments, :state, :string
    add_column :payments, :country, :string
    add_column :payments, :postal_code, :string
    add_column :payments, :phone_contry_code, :string
    add_column :payments, :phone_area_code, :string
    add_column :payments, :phone_number_code, :string

  end
end
