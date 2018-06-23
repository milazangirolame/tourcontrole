class Moip

  attr_reader :token, :key

  def initialize(token = nil, key = nil)
    @token = token || get_token
    @key = key || get_key
  end

  def call
    authentication
  end

  def puts_hello
    'hello world'
  end


  private

  def get_token
    ENV['MOIP_SANDBOX_TOKEN']
  end

  def get_key
    ENV['MOIP_SANDBOX_KEY']
  end

  def credentials
    Rails.application.credentials[Rails.env.to_sym][:moip]
  end

  def authentication
    Moip2::Api.new(moip_client)
  end

  def moip_client
    Moip2::Client.new(:sandbox, moip_auth)
  end

  def moip_auth
    auth = Moip2::Auth::OAuth.new(ENV['MOIP_SANDBOX_ACCESS_TOKEN'])
  end
end
