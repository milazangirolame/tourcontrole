class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.string :name
      t.string :token

      t.timestamps
    end
  end
end
