require "rails_helper"

RSpec.describe "Welcome Page", type: :feature do
  it "sees banner and log in button" do
    visit root_path

    expect(page).to have_content("Log In With FitBit")
    expect(page).to have_content("Welcome to Fitness Tracker")
  end
end
