class MostDangerousDayController < ApplicationController
  def index
    @start_date = Time.new(params[:start_date]).strftime('%B %e, %Y')
    @end_date = Time.new(params[:end_date]).strftime("%B #{params[:end_date].split('-').last.to_i}, %Y")
    conn = Faraday.new("https://api.nasa.gov/neo/rest/v1/feed?start_date=#{params[:start_date]}&end_date=#{params[:end_date]}&api_key=OMmFoPYWpMrG4LOLC4a8rTpiP7Dk36Ul87c2vSnj")
    response = conn.get
    raw_nasa_days = JSON.parse(response.body, symbolize_names: true)[:near_earth_objects]
    nasa_days = raw_nasa_days.map do |raw_nasa_day|
      NasaDay.new(raw_nasa_day)
    end
    @most_dangerous_day = nasa_days.max do |a, b|
      a.near_earth_objects.count <=> b.near_earth_objects.count
    end
  end
end

class NasaDay
  attr_reader :date, :asteroids

  def initialize(attrs)
    @date = Time.new(attrs.first.to_s).strftime("%B #{attrs.first.to_s.split('-').last.to_i}, %Y")
    @asteroids = attrs.last.map do |raw_asteroid|
      Asteroid.new(raw_asteroid)
    end
  end

  def near_earth_objects
    asteroids.select do |asteroid|
      asteroid.hazardous
    end
  end
end

class Asteroid
  attr_reader :neo_reference_id, :name, :hazardous

  def initialize(attrs)
    @neo_reference_id = attrs[:neo_reference_id]
    @name = attrs[:name].split(' ').last(2).join(' ')
    @hazardous = attrs[:is_potentially_hazardous_asteroid]
  end
end
