require 'spec_helper'

describe Asteroid do
  before(:each) do
    @asteroid = Asteroid.new({
      :neo_reference_id=>"2439898",
      :name=>"439898 (2000 TG2)",
      :is_potentially_hazardous_asteroid=>false
    })
  end

  context 'attributes' do
    it 'has a neo_reference_id' do
      expect(@asteroid.neo_reference_id).to eq("2439898")
    end

    it 'has a name' do
      expect(@asteroid.name).to eq("439898 (2000 TG2)")
    end

    it 'can be hazardous' do
      expect(@asteroid.hazardous).to eq(false)
    end
  end

  context 'instance methods' do
    it 'has a nickname' do
      expect(@asteroid.nickname).to eq("(2000 TG2)")
    end
  end
end
