class NasaDay
  attr_reader :date

  def initialize(attrs)
    @date = Time.parse(attrs.first.to_s).strftime('%B%e, %Y')
    @asteroids = attrs.last.map do |raw_asteroid|
      Asteroid.new(raw_asteroid)
    end
  end

  def near_earth_objects
    asteroids.select do |asteroid|
      asteroid.hazardous
    end
  end

  def self.all_in_range(dates)
    NasaService.get_url('feed', dates)[:near_earth_objects].map do |raw_day|
      new(raw_day)
    end
  end

  private
    attr_reader :asteroids
end
