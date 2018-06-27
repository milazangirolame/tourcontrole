class MoipApi
  require 'net/http'
  require 'json'
  require 'nokogiri'
  require 'base64'
  attr_reader :api
  def initialize()
    @api = Moip.new.call
  end

  def auth
    Base64.encode64("#{ENV['MOIP_SANDBOX_TOKEN']}:#{ENV['MOIP_SANDBOX_KEY']}")
  end

  def get_customers
    uri = URI.parse('https://sandbox.moip.com.br/v2/customers/')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.start
    request = Net::HTTP::Get.new(uri.request_uri, { authorization: "OAuth #{ENV['MOIP_SANDBOX_ACCESS_TOKEN']}" })
    response = http.request(request)
    # Nokogiri::HTML(response.body).inner_text
    JSON.parse(response.body)
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

  def create_merchant_account(store)
    account = api.accounts.create(tour_store_post_data(store))
    store.update(moip_id: account[:id], moip_access_token: account[:access_token], moip_channel_id: account[:channel_id]) unless account[:errors].present?
    account
  end

  def create_bank_info(bank_info)
    bank_account = api.bank_accounts.create(bank_info.tour_store.moip_id, bank_post_data(bank_info))
    bank_info.update(moip_id: bank_account[:id], status: bank_account[:status]) unless bank_account[:errors].present?
    bank_account
  end

  def update_bank_info(bank_info)
    api.bank_accounts.update(bank_info.moip_id, bank_post_data(bank_info))
  end


  def get_customer_moip_data(guest)
    guest.moip_id ? api.customer.show(guest.moip_id) : 'Customer without moip_id'
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

  private

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
          price: sales_order.events.first.price.to_i
        }
      ],
      customer: {
        id: sales_order.buyer.moip_id
      },
      receivers: [
        {
          type: 'SECONDARY',
          feePayor: false,
          moipAccount: {
            id: sales_order.events.first.activity.tour_store.moip_id
          },
          amount: {
            percentual: 90
          }
        },
        {
          type: 'PRIMARY',
          feePayor: true,
          moipAccount: {
            id: ENV['MOIP_SANDBOX_ACCOUNT_ID']
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
        number: sales_order.payment.cpf,
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
          number: "572.619.050-54",
        },
        identityDocument: {
          type: "RG",
          number: "35.868.057-8",
          issuer: "SSP",
          issueDate: "2000-12-12",
        },
        birthDate: "1990-01-01",
        phone: {
          countryCode: "55",
          areaCode: "11",
          number: '965213244',
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
        taxDocument: {
          type: 'CNPJ',
          number: store.business_tax_id
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

