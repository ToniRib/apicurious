require "rails_helper"

RSpec.describe "User Views Dashboard", type: :feature do
  it "has all of the user's data" do
    visit root_path
    mock_auth_hash

    VCR.use_cassette "load_dashboard" do
      click_on "Log In With FitBit"
    end

    expect(page).to have_content("Welcome, Toni Rib")

    within ".friends" do
      expect(page).to have_content("Carlos N.")
      expect(page).to have_content("Sharon R.")
      expect(page).to have_content("selby s.")
      expect(page).to have_content("Natasha")
      expect(page).to have_content("Emma W.")
      expect(page).to have_content("Toni")
      expect(page).to have_content("Monique")
    end

    within ".sleep-panel" do
      expect(page).to have_content("Time Asleep: 4 hours 20 minutes")
      expect(page).to have_content("Time Awake: 3 hours 10 minutes")
      expect(page).to have_content("Number of Awakenings: 20")
    end
  end
end
