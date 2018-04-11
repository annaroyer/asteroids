class Api::V1::User::FavoritesController < ApiBaseController
  def index
    favorites = current_user.favorites.map do |fav|
      NasaFavorite.new(fav)
    end
    render json: favorites, each_serializer: NasaFavoriteSerializer
  end
end
