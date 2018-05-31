class AddStartsAtAndEndsAtToActivity < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :starts_at, :datetime
    add_column :activities, :ends_at, :datetime
  end
end
