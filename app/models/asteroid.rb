class Asteroid
  attr_reader :neo_reference_id, :name, :hazardous

  def initialize(attrs)
    @neo_reference_id = attrs[:neo_reference_id]
    @name = attrs[:name].split(' ').last(2).join(' ')
    @hazardous = attrs[:is_potentially_hazardous_asteroid]
  end
end
