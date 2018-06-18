require 'rails_helper'

RSpec.describe IuguApi, type: :model do
  it 'Create Api Object' do 
    api = build(:iugu_api)
    expect(api).to be_kind_of IuguApi 
  end
  it 'Api default api_token to live' do
    api = build(:iugu_api)
    expect(api.api_token).to eq(ENV['IUGU_LIVE_TOKEN'])
  end

  it 'Api set api_token as test' do
    api = build(:iugu_api, test: true)
    expect(api.api_token).to eq(ENV['IUGU_TEST_TOKEN'])
  end
end
