require "rails_helper"

RSpec.describe "User Views Dashboard", type: :feature do
  it "has all of the user's data" do
    visit root_path
    mock_auth_hash

    VCR.use_cassette "load_dashboard" do
      click_on "Log In With FitBit"
    end

    expect(page).to have_content("Welcome, Toni Rib")

    within ".friends-panel" do
      expect(page).to have_content("Carlos N.")
      expect(page).to have_content("Sharon R.")
      expect(page).to have_content("selby s.")
      expect(page).to have_content("Natasha")
      expect(page).to have_content("Emma W.")
      expect(page).to have_content("Toni")
      expect(page).to have_content("Monique")
    end

    within ".sleep-patterns-panel" do
      expect(page).to have_content("Time Asleep: 4 hours 4 minutes")
      expect(page).to have_content("Time Awake: 3 hours 1 minutes")
      expect(page).to have_content("Number of Awakenings: 15")
    end

    within ".heart-rate-panel" do
      expect(page).to have_css("#heart-rate-chart")
      expect(page).to have_content("Today: 82 bpm")
    end

    within ".sleep-panel" do
      expect(page).to have_css("#sleep-chart")
      expect(page).to have_content("2hr 51min")
      expect(page).to have_content("awake 1x")
      expect(page).to have_content("restless 16x")
    end

    within ".badge-gallery" do
      expect(page).to have_content("30,000 steps in a day")
      expect(page).to have_content("150 floors in a day")
      expect(page).to have_content("1,600 lifetime miles")
      expect(page).to have_content("4,000 lifetime floors")
      expect(page).to have_content("-5 pounds")
    end

    within ".activity-panel" do
      expect(page).to have_css("#daily-steps-chart")
      expect(page).to have_css("#daily-floors-chart")
      expect(page).to have_css("#daily-calories-chart")
    end
  end
end
