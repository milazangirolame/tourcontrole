class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.integer :available_spots
      t.datetime :starts_at
      t.datetime :end_at
      t.references :activity, foreign_key: true

      t.timestamps
    end
  end
end
