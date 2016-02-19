require "spec_helper"

RSpec.describe DailyActivity, type: :model do
  it "has valid attributes" do
    daily_activity = build(:daily_activity)

    expect(daily_activity.date).to eq("02-16-2016")
    expect(daily_activity.steps).to eq(7500)
    expect(daily_activity.floors).to eq(11)
    expect(daily_activity.calories).to eq(2300)
  end
end
