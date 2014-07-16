class TehachapiController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def registry

  end

  def index
    weather = Weather.new
    @current_weather = weather.get_current
    @weather_forcast = weather.get_forcast
    @current_weather['description'] = weather.code_description(@current_weather['weatherCode'])
    @hotels = YAML.load_file("config/tehachapi_hotels.yml")[Rails.env]['hotels']
  end

  def restaurants
    @restaurants = YAML.load_file("config/tehachapi_restaurants.yml")[Rails.env]['restaurants']
  end

  def hotels
    @hotels = YAML.load_file("config/tehachapi_hotels.yml")[Rails.env]['hotels']
  end
 
end
