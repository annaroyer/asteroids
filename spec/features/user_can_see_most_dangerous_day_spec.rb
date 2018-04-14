require 'rails_helper'

describe "A guest user visits the root page and enters a start date and end date." do
  scenario "The resulting page will display the most dangerous day in that range based on which day has the most `is_potentially_dangerous_asteroid` set to `true`." do
    days_in_range = File.open('./spec/fixtures/days_in_range.json')
    stub_request(:get, "https://api.nasa.gov/neo/rest/v1/feed?api_key=#{ENV['NASA_API_KEY']}&end_date=2018-01-07&start_date=2018-01-01")
      .to_return(status: 200, body: days_in_range, headers: {})

    visit '/'

    fill_in :start_date, with: '2018-01-01'
    fill_in :end_date, with: '2018-01-07'
    click_on 'Determine Most Dangerous Day'

    expect(current_path).to eq('/most_dangerous_day')
    expect(page).to have_content('MOST DANGEROUS DAY')
    expect(page).to have_content("January 1, 2018 - January 7, 2018")
    expect(page).to have_content("January 1, 2018 has 3 potentially dangerous near earth objects")
    expect(page).to have_content("Name: (2014 KT76)")
    expect(page).to have_content("NEO Reference ID: 3672906")

    expect(page).to have_content("Name: (2001 LD)")
    expect(page).to have_content("NEO Reference ID: 3078262")

    expect(page).to have_content("Name: (2017 YR1)")
    expect(page).to have_content("NEO Reference ID: 3794979")
  end
end
