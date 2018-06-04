class AddRecurringToActivity < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :recurring, :text
  end
end
