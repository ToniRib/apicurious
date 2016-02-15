require "rails_helper"

RSpec.describe "The Welcome Page" do
  it "shows the correct information" do
    visit root_path

    expect(page).to have_content("Hello!")
  end

  it "toggles class with javascript", js: true do
    visit root_path

    expect(page).not_to have_content("This is hidden")

    click_on "Unhide!"

    expect(page).to have_content("This is hidden")
  end
end
