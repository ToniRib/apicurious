require "rails_helper"

RSpec.describe "User Logs In", type: :feature do
  xit "creates a new user if this is their first time logging in" do
    visit root_path
    click_on "Log In With FitBit"

    VCR.use_cassette "feature/user_login" do

    end
  end
end
