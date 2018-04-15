require 'rails_helper'

describe NasaService do
  context 'class methods' do
    describe '.get_url' do
      it 'returns the data from calling the feed endpoint of the nasa api' do
        VCR.use_cassette('feed') do
          dates = {start_date: '2018-01-01', end_date: '2018-01-07'}
          feed = NasaService.get_url('feed', dates)[:near_earth_objects]

          expect(feed.count).to eq(7)
        end
      end

      it 'returns the data from calling the neo endpoint of the nasa api' do
        VCR.use_cassette('neo') do
          asteroid = NasaService.get_url('neo/2153306')

          expect(asteroid[:neo_reference_id]).to eq('2153306')
          expect(asteroid[:name]).to eq('153306 (2001 JL1)')
          expect(asteroid[:is_potentially_hazardous_asteroid]).to eq(false)
        end
      end
    end
  end
end
