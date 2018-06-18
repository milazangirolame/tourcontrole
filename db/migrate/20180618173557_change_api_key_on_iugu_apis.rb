class ChangeApiKeyOnIuguApis < ActiveRecord::Migration[5.1]
  def change
    change_column :iugu_apis, :api_token, :string, default: :set_api_token
  end
end
