class AddEndsAtToActivity < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :ends_at, :time
  end
end
