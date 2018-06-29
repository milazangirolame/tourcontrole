class AddAmountToTransfers < ActiveRecord::Migration[5.1]
  def change
    add_monetize :transfers, :amount, currency: {present: false}
  end
end
