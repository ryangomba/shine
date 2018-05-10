require 'httparty'

class Wunderground
  
  include HTTParty
  format :json
  
  API_KEY = "9b046c5a8b7aa1b5"

  def self.current_temp(latitude, longitude)
    response = get("http://api.wunderground.com/api/#{API_KEY}/conditions/q/#{latitude},#{longitude}.json")
    return [response['current_observation']['temp_f'].to_i, 0].max
  end

end
