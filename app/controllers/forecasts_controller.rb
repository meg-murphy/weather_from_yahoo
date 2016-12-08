class ForecastsController < ApplicationController
  def index

    if params[:city]
      @city = params[:city]
    else
      @city = "fremont"
    end

    if params[:state]
      @state = params[:state]
    else
      @state = "ca"
    end

    forecast_data = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22#{@city}%2C%20#{@state}%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys").body
    
    forecasts = forecast_data["query"]["results"]["channel"]["item"]["forecast"]
    @forecasts_five_day = forecasts.take(5)
    @title = forecast_data["query"]["results"]["title"]
  end


end
