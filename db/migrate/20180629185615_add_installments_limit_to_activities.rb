class AddInstallmentsLimitToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :installments_limit, :integer
    add_column :activities, :custom_installments, :boolean, default: false, null: false
  end
end
