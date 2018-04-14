class Asteroid
  attr_reader :neo_reference_id, :name, :hazardous

  def initialize(attrs)
    @neo_reference_id = attrs[:neo_reference_id]
    @name = attrs[:name]
    @hazardous = attrs[:is_potentially_hazardous_asteroid]
  end

  def nickname
    name.split(' ').last(2).join(' ')
  end
end
