require 'rails_helper'

describe 'As a registered user' do
  context "When I send a 'GET' request to '/api/v1/user/favorites?api_key=abc123" do
    scenario 'Then I should receive a JSON response' do
      get '/api/v1/user/favorites?api_key=abc123'

      expect(response).to eq(favorites)
    end
  end
end

def favorites
  [
    {
      "id":1,
      "neo_reference_id": "2153306",
      "user_id": 1,
      "asteroid": {
        "name": "153306 (2001 JL1)",
        "is_potentially_hazardous_asteroid": false,
      }
    }
  ]
end
