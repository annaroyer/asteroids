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
    # @most_dangerous_day = nasa_days.max do |a, b|
    #   a.near_earth_objects.count <=> b.near_earth_objects.count
    # end
    @most_dangerous_day = NasaService.most_dangerous_day(params[:start_date], params[:end_date])
  end
end
