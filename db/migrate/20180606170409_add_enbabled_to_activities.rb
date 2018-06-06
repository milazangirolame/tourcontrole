class AddEnbabledToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :enabled, :boolean, null: true, default:true
  end
end
