require "spec_helper"

RSpec.describe Sleep, type: :model do
  it "has valid attributes" do
    sleep = Sleep.new(time_asleep: "320",
                      time_awake:  "300",
                      awakenings:  "17",
                      date:        "2016-2-16")

    expect(sleep.time_asleep).to eq(320)
    expect(sleep.time_awake).to eq(300)
    expect(sleep.awakenings).to eq(17)
    expect(sleep.date).to eq(Date.parse("2016-2-16"))
  end

  it "#logged? returns true if time asleep is greater than 0" do
    sleep = Sleep.new(time_asleep: "320",
                      time_awake:  "300",
                      awakenings:  "17",
                      date:        "2016-2-16")


    expect(sleep.logged?).to be true
  end

  it "#logged? returns false if time asleep is 0" do
    sleep = Sleep.new(time_asleep: "0",
                      time_awake:  "0",
                      awakenings:  "0",
                      date:        "2016-2-16")


    expect(sleep.logged?).to be false
  end

  it "#time_asleep_in_hours returns time asleep string" do
    sleep = Sleep.new(time_asleep: "320",
                      time_awake:  "150",
                      awakenings:  "17",
                      date:        "2016-2-16")

    expect(sleep.time_asleep_in_hours).to eq("5 hours 20 minutes")
  end

  it "#time_awake_in_hours returns time asleep string" do
    sleep = Sleep.new(time_asleep: "320",
                      time_awake:  "150",
                      awakenings:  "17",
                      date:        "2016-2-16")

    expect(sleep.time_awake_in_hours).to eq("2 hours 30 minutes")
  end
end
