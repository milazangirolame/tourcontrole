class CreateIuguApis < ActiveRecord::Migration[5.1]
  def change
    create_table :iugu_apis do |t|

      t.timestamps
    end
  end
end
