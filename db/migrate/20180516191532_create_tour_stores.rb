class CreateTourStores < ActiveRecord::Migration[5.1]
  def change
    create_table :tour_stores do |t|
      t.text :address
      t.string :phone
      t.string :website
      t.string :name
      t.text :description
      t.string :business_tax_id
      t.string :regulator_id
      t.string :logo
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
