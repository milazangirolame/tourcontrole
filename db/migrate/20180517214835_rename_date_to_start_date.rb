class RenameDateToStartDate < ActiveRecord::Migration[5.1]
  def change
    rename_column :activities, :date, :start_date
  end
end
