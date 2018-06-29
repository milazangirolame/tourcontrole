class CreateTransfers < ActiveRecord::Migration[5.1]
  def change
    create_table :transfers do |t|
      t.string :moip_id
      t.references :tour_store, foreign_key: true

      t.timestamps
    end
  end
end
