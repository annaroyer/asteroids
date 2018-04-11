require 'rails_helper'

describe 'As a registered user' do
  context "When I send a 'GET' request to '/api/v1/user/favorites?api_key=abc123" do
    scenario 'Then I should receive a JSON response' do
      uncle_jesse = User.create(name: "Jesse Katsopolis", email: "uncle.jesse@example.com")
      uncle_jesse.create_api_key(value: "abc123")
      uncle_jesse.favorites.create(neo_reference_id: "2153306")

      get "/api/v1/user/favorites?api_key=abc123"

      expect(response.status).to eq 200

      favorites = JSON.parse(response.body, symbolize_names: true)

      expect(favorites.first[:id]).to eq(1)
      expect(favorites.first[:neo_reference_id]).to eq("2153306")
      expect(favorites.first[:user_id]).to eq(1)
      expect(favorites.first[:asteriod][:name]).to eq("153306 (2001 JL1)")
      expect(favorites.first[:asteriod][:is_potentially_hazardous_asteroid]).to eq(false)
    end
  end
end

  #
  # [
  #   {
  #     "id":1,
  #     "neo_reference_id": "2153306",
  #     "user_id": 1,
  #     "asteroid": {
  #       "name": "153306 (2001 JL1)",
  #       "is_potentially_hazardous_asteroid": false,
  #     }
  #   }
  # ]
  #
