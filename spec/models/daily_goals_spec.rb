require "spec_helper"

RSpec.describe DailyGoals, type: :model do
  it "has valid attributes" do
    daily_goals = build(:daily_goals)

    expect(daily_goals.steps).to eq(10000)
    expect(daily_goals.calories).to eq(2600)
    expect(daily_goals.floors).to eq(18)
  end
end
