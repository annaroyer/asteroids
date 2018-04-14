require 'rails_helper'

describe NasaDay do
  subject { NasaDay.new(attributes) }

  context 'attributes' do
    it 'has a date' do
      expect(subject.date).to eq('January 4, 2018')
    end
  end

  context 'instance methods' do
    describe '#near_earth_objects' do
      it 'returns all potentially hazardious asteroids' do
        expect(subject.near_earth_objects.count).to eq(10)
      end
    end
  end

  context 'class methods' do
    describe '.all_in_range' do
      it 'returns all days within a range' do
        
      end
    end
  end
end

def attributes
  [:"2018-01-04",
   [{
     :neo_reference_id=>"2439898",
     :name=>"439898 (2000 TG2)",
     :is_potentially_hazardous_asteroid=>false,
     },
    {
     :neo_reference_id=>"2440212",
     :name=>"440212 (2004 OB)",
     :is_potentially_hazardous_asteroid=>true,
     },
    {
     :neo_reference_id=>"3553988",
     :name=>"(2010 XR69)",
     :is_potentially_hazardous_asteroid=>false,
     },
    {
     :neo_reference_id=>"3586023",
     :name=>"(2011 VQ5)",
     :is_potentially_hazardous_asteroid=>false,
     },
    {
     :neo_reference_id=>"3703780",
     :name=>"(2015 AC45)",
     :is_potentially_hazardous_asteroid=>false,
     },
    {
     :neo_reference_id=>"3767152",
     :name=>"(2017 BF30)",
     :is_potentially_hazardous_asteroid=>false,
     },
    {
     :neo_reference_id=>"2505093",
     :name=>"505093 (2011 VQ5)",
     :is_potentially_hazardous_asteroid=>false,
     },
    {
     :neo_reference_id=>"3797476",
     :name=>"(2018 AK3)",
     :is_potentially_hazardous_asteroid=>false,
     },
    {
     :neo_reference_id=>"3797861",
     :name=>"(2018 BM3)",
     :is_potentially_hazardous_asteroid=>true,
     },
    {
     :neo_reference_id=>"3799865",
     :name=>"(2018 DM4)",
     :is_potentially_hazardous_asteroid=>false,
     }]
   ]
end
