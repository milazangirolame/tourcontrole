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

  def get_customer_moip_data(guest)
    guest.moip_id ? api.customer.show(guest.moip_id) : 'Customer without moip_id'
  end

  def  create_moip_order(order)
    uri = URI.parse('https://sandbox.moip.com.br/v2/orders')
    request = Net::HTTP::Post.new(uri.path)
    request.content_type = 'application/json'
    request.add_field('authorization',"OAuth #{ENV['MOIP_SANDBOX_ACCESS_TOKEN']}" )
    request.body = (order_post_data(order))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.start
    response = http.request(request)
    JSON.parse(response.body)
  end


  def order_post_data(sales_order)
    JSON.generate(
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
end

