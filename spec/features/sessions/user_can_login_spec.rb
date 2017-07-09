require 'rails_helper'

describe "User wants to login with " do
  xscenario "they click login and see their name" do
    VCR.use_cassette("user_can_search_for_stations") do
      visit "/"
      click_on "Login"

  # Then I should be on page "/search" with parameters visible in the url
      expect(current_path).to eq("/search")
      expect(page).to have_selector(".station", count: 10)

      within first(".station") do
        expect(page).to have_selector(".station_name")
        expect(page).to have_selector(".station_address")
        expect(page).to have_selector(".station_fuel_type")
        expect(page).to have_selector(".station_distance")
        expect(page).to have_selector(".station_access_times")
      end
    end
  end
end
