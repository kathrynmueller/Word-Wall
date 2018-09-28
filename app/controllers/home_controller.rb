class HomeController < ApplicationController
  def index
  end

  def test
    header = {"Accept": "application/json", 
    	"app_id": "#{ENV['oed_app_id']}", 
    	"app_key": "#{ENV['oed_app_key']}"}
    @response = HTTParty.get("https://od-api.oxforddictionaries.com:443/api/v1/entries/en/ace", header)
    # @location = response['name']
  end
end
