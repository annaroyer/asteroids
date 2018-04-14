class Favorite < ApplicationRecord
  belongs_to :user

  def asteroid
    raw_asteroid = NasaService.get_url("neo/#{neo_reference_id}")
    Asteroid.new(raw_asteroid)
  end
end
