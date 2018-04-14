class NasaService

  def self.asteroid(neo_reference_id)
    raw_asteroid = get_url("neo/#{neo_reference_id}")
    Asteroid.new(raw_asteroid)
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
