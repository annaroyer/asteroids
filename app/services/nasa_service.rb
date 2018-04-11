class NasaService

  def self.most_dangerous_day(start_date, end_date)
    get_nasa_days(start_date, end_date).max do |a, b|
      a.near_earth_objects.count <=> b.near_earth_objects.count
    end
  end

  def self.asteroid(neo_reference_id)
    conn = Faraday.new("https://api.nasa.gov/neo/rest/v1/neo/#{neo_reference_id}?api_key=OMmFoPYWpMrG4LOLC4a8rTpiP7Dk36Ul87c2vSnj")
    response = conn.get
    raw_asteroid = JSON.parse(response.body, symbolize_names: true)
    Asteroid.new(raw_asteroid)
  end

  private

    def self.get_nasa_days(start_date, end_date)
      conn = Faraday.new("https://api.nasa.gov/neo/rest/v1/feed?start_date=#{start_date}&end_date=#{end_date}&api_key=OMmFoPYWpMrG4LOLC4a8rTpiP7Dk36Ul87c2vSnj")
      response = conn.get
      raw_days = JSON.parse(response.body, symbolize_names: true)[:near_earth_objects]
      raw_days.map do |day|
        NasaDay.new(day)
      end
    end
end
