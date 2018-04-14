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
        expect(subject.near_earth_objects.count).to eq(2)
      end
    end
  end

  context 'class methods' do
    describe '.all_in_range' do
      it 'returns all days within a range' do
        days_in_range = File.open('./spec/fixtures/days_in_range.json')
        stub_request(:get, "https://api.nasa.gov/neo/rest/v1/feed?api_key=#{ENV['NASA_API_KEY']}&end_date=2018-01-07&start_date=2018-01-01")
          .to_return(status: 200, body: days_in_range, headers: {})

        dates = {start_date: '2018-01-01', end_date: '2018-01-07'}

        nasa_days = NasaDay.all_in_range(dates)

        expect(nasa_days.count).to eq(7)
        nasa_days.each do |day|
          expect(day.class).to eq(NasaDay)
        end
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
