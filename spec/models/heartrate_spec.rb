require "spec_helper"

RSpec.describe Heartrate, type: :model do
  it "can be initialized with a date and rate" do
    heartrate = Heartrate.new(date: "2016-02-16", rate: 84)

    expect(heartrate.date).to eq("2016-02-16")
    expect(heartrate.rate).to eq(84)
  end
end
