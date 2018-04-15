class AsteroidSerializer < ActiveModel::Serializer
  alias :read_attribute_for_serialization :send
  attributes :name, :is_potentially_hazardous_asteroid

  def name
    object.name
  end

  def is_potentially_hazardous_asteroid
    object.hazardous
  end
end
