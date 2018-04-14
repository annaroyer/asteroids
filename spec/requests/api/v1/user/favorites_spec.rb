require 'rails_helper'

describe 'As a registered user' do
  context "When I send a 'GET' request to '/api/v1/user/favorites?api_key=abc123" do
    before(:each) do
      uncle_jesse = User.create(name: "Jesse Katsopolis", email: "uncle.jesse@example.com")
      uncle_jesse.create_api_key(value: "abc123")
      uncle_jesse.favorites.create(neo_reference_id: "2153306")
    end

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
      expect(favorites.first[:asteroid][:name]).to eq("153306 (2001 JL1)")
      expect(favorites.first[:asteroid][:is_potentially_hazardous_asteroid]).to eq(false)
    end
  end

  context 'When I send a POST request to "/api/v1/user/favorites" with an "api_key" of "abc123" and a "neo_reference_id" of "2021277"' do
    scenario 'Then I should receive a JSON response' do
      post "/api/v1/user/favorites?api_key=abc123&neo_reference_id=2021277"

      expect(response.status).to eq 200

      favorite = JSON.parse(response.body, symbolize_names: true)

      expect(favorite[:id]).to eq(2)
      expect(favorite[:neo_reference_id]).to eq("2021277")
      expect(favorite[:user_id]).to eq(1)
      expect(favorite[:asteroid][:name]).to eq("21277 (1996 TO5)")
      expect(favorite[:asteroid][:is_potentially_hazardous_asteroid]).to eq(false)
    end
  end
end

#
# When I send a POST request to "/api/v1/user/favorites" with an 'api_key' of 'abc123' and a 'neo_reference_id' of '2021277'
# Then I should receive a response with a status code of 200
# And the body should be JSON as follows:```
#
# ```{
#   "id":2,
#   "neo_reference_id": "2021277",
#   "user_id": 1,
#   "asteroid": {
#     "name": "21277 (1996 TO5)",
#     "is_potentially_hazardous_asteroid": false,
#   }
# }```
