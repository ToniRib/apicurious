require "rails_helper"

RSpec.describe "User Logs In", type: :feature do
  it "creates a new user if this is their first time logging in" do
    visit root_path
    mock_auth_hash
    click_on "Log In With FitBit"

    expect(current_path).to eq(dashboard_path)
    expect(User.last.full_name).to eq("Toni Rib")
  end
end
