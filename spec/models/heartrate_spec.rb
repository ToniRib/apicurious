require "spec_helper"

RSpec.describe Heartrate, type: :model do
  it "can be initialized with a date and rate" do
    heartrate = build(:heartrate)

    expect(heartrate.date).to eq("2016-02-16")
    expect(heartrate.rate).to eq(84)
  end
end
