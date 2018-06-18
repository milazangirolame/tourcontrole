require 'rails_helper'

RSpec.describe BankingInformation, type: :model do
  it "Saves account_type" do
    conta = build(:banking_information)
    expect(conta.account_type).to eq("Corrente")
  end

    it "Saves bank" do
    conta = build(:banking_information)
    test = conta.bancos.include?(conta.bank)
    expect(test).to eq(true)
  end

  it 'Set api_live_token to tour_store' do
    account = build(:banking_information)
    store = account.tour_store
    expect(store.api_live_token).not_to be_nil
  end

  it 'Set api_test_token to tour_store' do
    account = build(:banking_information)
    store = account.tour_store
    expect(store.api_test_token).not_to be_nil
  end

  it 'Set api_user_token to tour_store from callback' do
    account = build(:banking_information)
    store = account.tour_store
    expect(store.api_user_token).not_to be_nil
  end
 
end
