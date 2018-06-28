class Moip

  attr_reader :access_token

  def initialize(access_token = nil)
    @access_token = access_token || ENV['MOIP_SANDBOX_ACCESS_TOKEN']
  end

  def call
    authentication
  end

  private

  def authentication
    Moip2::Api.new(moip_client)
  end

  def moip_client
    Moip2::Client.new(:sandbox, moip_auth)
  end

  def moip_auth
    Moip2::Auth::OAuth.new(access_token)
  end
end
