require "spec_helper"

RSpec.describe Badge, type: :model do
  it "has valid attributes" do
    badge = build(:badge)

    img = "http://static0.fitbit.com/images/badges_new/" \
          "125px/badge_daily_steps30k.png"

    expect(badge.type).to eq("DAILY_STEPS")
    expect(badge.date).to eq("2016-02-16")
    expect(badge.image).to eq(img)
    expect(badge.value).to eq(30000)
    expect(badge.description).to eq("30000 steps in a day")
  end
end
