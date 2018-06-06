class RenameEndAtOnEventsToEndsAt < ActiveRecord::Migration[5.1]
  def change
    rename_column :events, :end_at, :ends_at
  end
end
