class RemoveFieldsFromActivities < ActiveRecord::Migration[5.1]
  def change
    remove_column :activities, :starts_at
    remove_column :activities, :ends_at
    remove_column :activities, :start_date
    remove_column :activities, :end_date
    remove_column :activities, :recurring
  end
end
