class AddAgDigitToBankingInformations < ActiveRecord::Migration[5.1]
  def change
    add_column :banking_informations, :ag_digit, :string
    add_column :banking_informations, :cc_digit, :string
    add_column :banking_informations, :holder_name, :string
    add_column :banking_informations, :holder_id, :string
    add_column :banking_informations, :holder_id_type, :string
    add_column :banking_informations, :status, :string
    add_column :banking_informations, :moip_id, :string
  end
end
