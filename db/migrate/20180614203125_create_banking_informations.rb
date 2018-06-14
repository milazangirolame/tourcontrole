class CreateBankingInformations < ActiveRecord::Migration[5.1]
  def change
    create_table :banking_informations do |t|
      t.string :bank
      t.string :bank_ag
      t.string :account_type
      t.string :bank_cc
      t.references :tour_store, foreign_key: true

      t.timestamps
    end
  end
end
