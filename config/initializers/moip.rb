auth = Moip2::Auth::OAuth.new(ENV['MOIP_SANDBOX_ACCESS_TOKEN'])
client = Moip2::Client.new(:sandbox, auth)
api = Moip2::Api.new(client)
