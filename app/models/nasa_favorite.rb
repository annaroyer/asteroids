class NasaFavorite < SimpleDelegator
  def asteroid
    NasaService.asteroid(self.neo_reference_id)
  end
end
