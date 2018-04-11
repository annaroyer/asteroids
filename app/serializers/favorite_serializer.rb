class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :neo_reference_id, :user_id, :asteroid

  def asteroid
    asteroid = NasaService.asteroid(object.neo_reference_id)
    AsteroidSerializer.new(asteroid)
  end
end
