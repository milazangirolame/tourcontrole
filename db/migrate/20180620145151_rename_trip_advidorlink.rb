class RenameTripAdvidorlink < ActiveRecord::Migration[5.1]
  def change
    rename_column :tour_stores, :trip_advisor_ling, :trip_advisor_link
  end
end
