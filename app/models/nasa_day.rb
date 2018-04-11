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
