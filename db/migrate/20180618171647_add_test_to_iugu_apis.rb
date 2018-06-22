class AddTestToIuguApis < ActiveRecord::Migration[5.1]
  def change
    add_column :iugu_apis, :test, :boolean, default: false, null: false
  end
end
