require 'net/http'

class WeatherController < ActionController::Base
    def forecast
        json = Rails.cache.fetch('forecast', expires_in: 15.minutes) do
            uri = URI.parse("https://api.darksky.net/forecast/#{Rails.application.secrets.darksky_api_key}/37.8267,-122.4233")
            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = true
            http.get(uri.request_uri).body
        end
        
        @data = JSON.parse(json, symbolize_names: true)
        @currently = @data[:currently]
    end    
end