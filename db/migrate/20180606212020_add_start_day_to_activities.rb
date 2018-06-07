class AddStartDayToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :start_day, :date
  end
end
