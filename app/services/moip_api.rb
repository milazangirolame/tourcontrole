class MoipApi
  require 'net/http'
  require 'json'
  require 'nokogiri'
  require 'base64'
  attr_reader :api, :platform_token
  def initialize(store = nil)
    @api = Moip.new(init_token(store)).call
    @platform_token = ENV['MOIP_SANDBOX_ACCESS_TOKEN']
  end

  def create_order(order)
    moip_order = api.order.create(order_post_data(order))
    order.update(moip_id: moip_order[:id], status: moip_order[:status]) unless moip_order[:errors].present?
    moip_order
  end

  def create_customer(order)
    customer = api.customer.create(customer_post_data(order))
    order.buyer.update(moip_id: customer[:id]) unless customer[:errors].present?
    customer
  end

  def create_payment(order, hash)
    payment = api.payment.create(order.moip_id, payment_post_data(order, hash))
    order.payment.update(moip_id: payment[:id], status: payment[:status]) unless payment[:errors].present?
    payment
  end

  def create_store(store)
    account = api.accounts.create(tour_store_post_data(store))
    store.update(moip_id: account[:id], moip_access_token: account[:access_token], moip_channel_id: account[:channel_id]) unless account[:errors].present?
    account
  end

  def create_bank(bank_info)
    bank_account = api.bank_accounts.create(bank_info.tour_store.moip_id, bank_post_data(bank_info))
    bank_info.update(moip_id: bank_account[:id], status: bank_account[:status]) unless bank_account[:errors].present?
    bank_account
  end

  def update_bank(bank_info)
    api.bank_accounts.update(bank_info.moip_id, bank_post_data(bank_info))
  end

  def get_customer(guest)
    guest.moip_id ? api.customer.show(guest.moip_id) : 'Customer without moip_id'
  end

  def get_customers(store = nil)
    auth = (store && store.moip_access_token) ? store.moip_access_token : ENV['MOIP_SANDBOX_ACCESS_TOKEN']
    uri = URI.parse('https://sandbox.moip.com.br/v2/customers/')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.start
    request = Net::HTTP::Get.new(uri.request_uri, { authorization: "OAuth #{auth}" })
    response = http.request(request)
    JSON.parse(response.body)
  end

  def get_payment(order)
    order.payment.moip_id? ? api.payment.show(order.payment.moip_id) : 'No moip_id'
  end

  def get_order(order)
    order.moip_id? ? api.order.show(order.moip_id) : 'No moip_id'
  end

  def get_orders
    api.order.find_all()
  end

  def get_bank(store)
    set_token(store)
    bank_id = store.banking_information.moip_id
    bank_id ? result = api.bank_accounts.show(bank_id).to_hash : 'No moip_id'
    restart_token
    result
  end

  def get_banks(store)
    set_token(store)
    id = store.moip_id
    id ? result = api.bank_accounts.find_all(id).to_hash : 'No moip_id'
    restart_token
    result
  end

  def get_balance
    api.balances.show().to_hash
  end


  def  post_moip_order(order)
    uri = URI.parse('https://sandbox.moip.com.br/v2/orders')
    request = Net::HTTP::Post.new(uri.path)
    request.content_type = 'application/json'
    request.add_field('authorization',"OAuth #{ENV['MOIP_SANDBOX_ACCESS_TOKEN']}" )
    request.body = JSON.generate(order_post_data(order))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.start
    response = http.request(request)
    JSON.parse(response.body)
  end

  def set_token(store)
    api.client.auth.instance_variable_set(:'@oauth', store.moip_access_token) unless store.moip_access_token.nil?
  end

  def restart_token
    api.client.auth.instance_variable_set(:'@oauth', platform_token)
  end

  def generate_self_token
    api.connect.authorize(
      client_id: ENV['MOIP_SANDBOX_ID'],
      client_secret: ENV['MOIP_SANDBOX_SECRET'],
      code: ENV['MOIP_SANDBOX_CODE'],
      redirect_uri: ENV['MOIP_REDIRECT_URI'],
      grant_type: "authorization_code"
      )
  end

  private

  def token_present?(store)
    store && store.moip_access_token
  end

  def init_token(store)
    token_present?(store) ? store.moip_access_token : nil
  end

  def order_post_data(sales_order)
    (
    {
      ownId: sales_order.api_other_id,
      amount: {
        currency: 'BRL',
        subtotals: {
          shipping: 0
        }
      },
      items: [
        {
          product: sales_order.events.first.activity.name,
          category: 'OTHER_CATEGORIES',
          quantity: sales_order.bookings.count,
          detail: sales_order.events.first.activity.description,
          price: sales_order.activity.price.fractional
        }
      ],
      customer: {
        id: sales_order.buyer.moip_id
      },
      receivers: [
        {
          type: 'PRIMARY',
          feePayor: false,
          moipAccount: {
            id: sales_order.events.first.activity.tour_store.moip_id
          },
          amount: {
            percentual: 90
          }
        },
        {
          type: 'SECONDARY',
          feePayor: true,
          moipAccount: {
            id: ENV['MOIP_SANDBOX_ACCOUNT_ID'],
          },
          amount: {
            percentual: 10
          }
        }
      ]
    })
  end

  def customer_post_data(sales_order)
    ({
      ownId: sales_order.buyer.api_other_id,
      fullname: sales_order.buyer.full_name,
      email: sales_order.buyer.email,
      phone: {
        areaCode: sales_order.payment.phone_area_code,
        number: sales_order.payment.phone_number,
      },
      birthDate: "1990-10-22",
      taxDocument: {
        type: "CPF",
        number: "57261905054",
      },
      shippingAddress: {
        street: sales_order.payment.street,
        streetNumber: sales_order.payment.street_number,
        complement: "",
        district: sales_order.payment.district,
        city: sales_order.payment.city,
        state: sales_order.payment.state,
        country: "BRA",
        zipCode: sales_order.payment.postal_code,
      },
    })
  end

  def payment_post_data(sales_order, hash)
    ({
      installment_count: sales_order.payment.installments,
      funding_instrument: {
        method: "CREDIT_CARD",
        credit_card: {
          # You can generate the following hash using a Moip Javascript SDK
          # where you use the customer credit_card data and your public key
          # to create the hash.
          # Read more about creating credit card hash here:
          # https://dev.moip.com.br/v2.0/docs/criptografia-de-cartao
          hash:  hash,
          holder: {
            fullname: sales_order.payment.name,
            birthdate: "1988-12-30",
            taxDocument: {
              type: "CPF",
              number: sales_order.payment.cpf,
            },
            phone: {
              countryCode: "55",
              areaCode: sales_order.payment.phone_area_code,
              number: sales_order.payment.phone_number,
            },
            billingAddress: {
                   city: sales_order.payment.city,
                   district: sales_order.payment.district,
                   street: sales_order.payment.street,
                   streetNumber: sales_order.payment.street_number,
                   zipCode: sales_order.payment.postal_code,
                   state: sales_order.payment.state,
                   country: "BRA"
            },
          },
        },
      }
    })
  end

  def tour_store_post_data(store)
    {
      email: {
        address: store.user.email,
      },
      person: {
        name: store.user.first_name,
        lastName: store.user.last_name,
        taxDocument: {
          type: "CPF",
          number: store.legal_representant_id,
        },
        birthDate: "1990-01-01",
        phone: {
          countryCode: "55",
          areaCode: "11",
          number: store.phone,
        },
        address: {
          street: store.street_name,
          streetNumber: store.street_number,
          district: store.neighborhood,
          zipCode: store.postal_code,
          city: store.city,
          state: store.state_code,
          country: 'BRA',
        },
      },
      type: "MERCHANT",
      transparentAccount: true,
      company: {
        name: store.name,
        businessName: store.name,
        taxDocument: {
          type: 'CNPJ',
          number: store.business_tax_id
        },
        phone: {
          countryCode: "55",
          areaCode: "11",
          number: store.phone,
        },
        mainActivity: {
          description: store.description
        },
        address: {
          street: store.street_name,
          streetNumber: store.street_number,
          district: store.neighborhood,
          zipCode: store.postal_code,
          city: store.city,
          state: store.state_code,
          country: 'BRA',
        }
      }
    }
  end

  def bank_post_data(banking_information)
    {
      bankNumber: banking_information.bank_code,
      agencyNumber: banking_information.bank_ag.to_i,
      agencyCheckNumber: banking_information.ag_digit,
      accountNumber: banking_information.bank_cc.to_i,
      accountCheckNumber: banking_information.cc_digit.to_i,
      type: banking_information.account_type,
      holder: {
        taxDocument: {
          type: banking_information.holder_id_type,
          number: banking_information.holder_id.to_i,
        },
        fullname: banking_information.holder_name,
      }
    }
  end
end

