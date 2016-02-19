require "spec_helper"

RSpec.describe WeeklyGoals, type: :model do
  it "has valid attributes" do
    weekly_goals = build(:weekly_goals)

    expect(weekly_goals.steps).to eq(70000)
    expect(weekly_goals.calories).to eq(18200)
    expect(weekly_goals.floors).to eq(126)
  end

  it "#set_calorie_goal updates the calories goal" do
    weekly_goals = build(:weekly_goals)
    weekly_goals.set_calorie_goal(20000)

    expect(weekly_goals.calories).to eq(20000)
  end
end
