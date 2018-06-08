class AddSlugToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :slug, :string
  end
end
