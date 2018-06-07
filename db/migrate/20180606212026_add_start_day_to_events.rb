class AddStartDayToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :start_day, :date
  end
end
