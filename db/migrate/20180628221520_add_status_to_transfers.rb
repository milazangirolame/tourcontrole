class AddStatusToTransfers < ActiveRecord::Migration[5.1]
  def change
    add_column :transfers, :status, :string
  end
end
