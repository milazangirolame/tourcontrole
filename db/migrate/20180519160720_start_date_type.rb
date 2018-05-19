class StartDateType < ActiveRecord::Migration[5.1]
  def change
    change_column :activities, :start_date, :datetime
  end
end
