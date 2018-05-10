require 'httparty'

class JsonParser < HTTParty::Parser
  def json
    puts 'Parsing!'
    puts body.inspect
  end
end

class UrbanAirship
  
  APP_KEY = "jk1fEK12Tkm_QAuVqhWQZQ"
  APP_SECRET = "yXYZt7mVQq2TieKmXKxNMg"
  
  include HTTParty
  base_uri "https://go.urbanairship.com/api"
  basic_auth APP_KEY, APP_SECRET
  
  parser JsonParser

  def self.push_badge(token, temp)
    puts 'Sending push notification'
    body = {
      device_tokens: [token],
      aps: {
        badge: temp,
        alert: "Current temp: #{temp}",
      },
    }.to_json
    puts body
    request = post('/push/',
      body: body,
      headers: { 'Content-Type' => 'application/json' }
    )
    # puts "REQUEST", request.request.inspect
    puts request.response.class
    return request.response.class == Net::HTTPOK
  end

end
