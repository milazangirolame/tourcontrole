class AddStartsAtToActivity < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :starts_at, :time
  end
end
