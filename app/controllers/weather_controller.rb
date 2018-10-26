require 'net/http'

class WeatherController < ActionController::Base
    def forecast
        lat = params[:lat]
        lng = params[:lng]
        json = Rails.cache.fetch("forecast:#{lat},#{lng}", expires_in: 15.minutes) do
            uri = URI.parse("https://api.darksky.net/forecast/#{Rails.application.secrets.darksky_api_key}/#{lat},#{lng}")
            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = true
            http.get(uri.request_uri).body
        end
        
        @data = JSON.parse(json, symbolize_names: true)
        @currently = @data[:currently]
    end    
end