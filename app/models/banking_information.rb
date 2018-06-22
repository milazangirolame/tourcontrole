class BankingInformation < ApplicationRecord
  belongs_to :tour_store
  validates :account_type, :bank_cc, :bank_ag, :bank, presence: true
  after_create :create_iugu_subaccount

  def bancos
    ['Itaú', 'Bradesco', 'Caixa Econômica', 'Banco do Brasil', 'Santander', 'Banrisul', 'Sicredi', 'Sicoob', 'Inter', 'BRB']
  end

  def account_type_options
    ['Corrente', 'Poupança']
  end

  def create_iugu_subaccount
    api = IuguApi.new
    resp = api.post('/marketplace/create_account', {
      "name" => tour_store.name,
      "commission_percent" => tour_store.comission_percent
    })
    if resp[:success]
      body = resp[:body]
      tour_store.iugu_account_id = body["account_id"]
      tour_store.api_live_token = body["live_api_token"]
      tour_store.api_test_token = body["test_api_token"]
      tour_store.api_user_token = body["user_api_token"]
      tour_store.save
    else
      @errors = resp[:body]["errors"]
    end
    resp[:success]
  end

end
