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
      ownId: sales_order.id,
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
            percetual: 90
          }
        },
        {
          type: 'PRIMARY',
          feePayor: true,
          moipAccount: {
            id: ENV['MOIP_SANDBOX_ACCOUNT_ID']
          },
          amount: {
            percetual: 10
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
end

