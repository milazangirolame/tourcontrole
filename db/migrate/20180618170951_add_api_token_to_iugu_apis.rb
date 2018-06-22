class AddApiTokenToIuguApis < ActiveRecord::Migration[5.1]
  def change
    add_column :iugu_apis, :api_token, :string
  end
end
