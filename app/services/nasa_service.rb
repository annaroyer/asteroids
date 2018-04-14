class NasaService

  def self.most_dangerous_day(start_date, end_date)
    get_nasa_days(start_date: start_date, end_date: end_date).max do |a, b|
      a.near_earth_objects.count <=> b.near_earth_objects.count
    end
  end

  def self.asteroid(neo_reference_id)
    raw_asteroid = get_url('neo', {neo_reference_id: neo_reference_id})
    Asteroid.new(raw_asteroid)
  end

  def self.get_nasa_days(params)
    get_url('feed', params)[:near_earth_objects].map do |day|
      NasaDay.new(day)
    end
  end

  def self.get_url(url, params={})
    response = conn.get url, params.merge(api_key: ENV['NASA_API_KEY'])
    JSON.parse(response.body, symbolize_names: true)
  end

  private

    def self.conn
      Faraday.new('https://api.nasa.gov/neo/rest/v1')
    end
end
