class AddEndDateToActivity < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :end_date, :date
  end
end
