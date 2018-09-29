class HomeController < ApplicationController
  def index
  	if params[:word].present?
  		parameters = {
      headers: {
        "Accept": "application/json",
        "app_id": "#{ENV['oed_app_id']}",
        "app_key": "#{ENV['oed_app_key']}",
        }
      }
    lemmatron = HTTParty.get("https://od-api.oxforddictionaries.com:443/api/v1/inflections/en/#{params[:word]}", parameters)
    @inflection = lemmatron['results'][0]['lexicalEntries'][0]['inflectionOf'][0]['text']
	    if @inflection == params[:word]
	    	response = HTTParty.get("https://od-api.oxforddictionaries.com:443/api/v1/entries/en/#{params[:word]}", parameters)
    		@definition = response['results'][0]['lexicalEntries'][0]['entries'][0]['senses'][0]['definitions'][0]
    	elsif @inflection != params[:word]
    		response = HTTParty.get("https://od-api.oxforddictionaries.com:443/api/v1/entries/en/#{@inflection}", parameters)
    		@definition = response['results'][0]['lexicalEntries'][0]['entries'][0]['senses'][0]['definitions'][0]
  
    			
 
	    end
    # response = HTTParty.get("https://od-api.oxforddictionaries.com:443/api/v1/entries/en/#{params[:word]}", parameters)
    # @definition = response['results'][0]['lexicalEntries'][0]['entries'][0]['senses'][0]['definitions'][0]
 	end
  end

  def test

  	parameters = {
      headers: {
        "Accept": "application/json",
        "app_id": "#{ENV['oed_app_id']}",
        "app_key": "#{ENV['oed_app_key']}",
        }
      }
    response = HTTParty.get("https://od-api.oxforddictionaries.com:443/api/v1/entries/en/ace", parameters)
    @provider = response['results'][0]['lexicalEntries'][0]['entries'][0]['senses'][0]['definitions'][0]

    # header = {"Accept": "application/json", 
    # 	"app_id": "#{ENV['oed_app_id']}", 
    # 	"app_key": "#{ENV['oed_app_key']}"}
    # @response = HTTParty.get("https://od-api.oxforddictionaries.com:443/api/v1/entries/en/ace", header)
    # @location = response['name']
  end
end
