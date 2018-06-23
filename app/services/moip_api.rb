class MoipApi
  require 'net/http'
  require 'json'
  require 'nokogiri'
  require 'base64'

  def initialize
  end

  def auth
    Base64.encode64("#{ENV['MOIP_SANDBOX_TOKEN']}:#{ENV['MOIP_SANDBOX_KEY']}")
  end

  def get_customers
    uri = URI.parse('https://sandbox.moip.com.br/v2/customers/')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.start
    request = Net::HTTP::Get.new(uri.request_uri, { authorization: ENV['MOIP_SANDBOX_ACCESS_TOKEN'] })
    response = http.request(request)
    # Nokogiri::HTML(response.body).inner_text
    JSON.parse(response.body)
  end
end

