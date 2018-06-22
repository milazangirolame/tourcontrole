class RemoveApiTokenFromIuguApis < ActiveRecord::Migration[5.1]
  def change
    remove_column :iugu_apis, :api_token
  end
end
