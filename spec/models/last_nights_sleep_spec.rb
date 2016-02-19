require "spec_helper"

RSpec.describe LastNightsSleep, type: :model do
  it "has valid attributes" do
    last = build(:last_nights_sleep)

    expect(last.restless_count).to eq(17)
    expect(last.awake_count).to eq(3)
    expect(last.minutes_asleep).to eq(206)
    expect(last.start_time).to eq("2016-02-16T23:21:00.000")
    expect(last.date).to eq("2016-02-16")
    expect(last.time_in_bed).to eq(520)
    expect(last.minute_data).to eq(minute_data)
  end

  it "#asleep_time_hours returns number of hours asleep" do
    last = build(:last_nights_sleep)

    expect(last.asleep_time_hours).to eq(3)
  end

  it "#asleep_time_minutes returns number of minutes minus hours asleep" do
    last = build(:last_nights_sleep)

    expect(last.asleep_time_minutes).to eq(26)
  end

  it "#end_time calculates wake up time" do
    last = build(:last_nights_sleep)
    end_time = Time.parse(last.start_time) + (last.time_in_bed * 60)

    expect(last.end_time).to eq(end_time)
  end

  it "#fell_asleep_at shows hour and minute of start time" do
    last = build(:last_nights_sleep)

    expect(last.fell_asleep_at).to eq("11:21")
  end

  it "#woke_up_at shows hour and minute of end time" do
    last = build(:last_nights_sleep)

    expect(last.woke_up_at).to eq(" 8:01")
  end

  def minute_data
    [
      {
        "dateTime":"00:00:00",
        "value": "3"
      },
      {
        "dateTime":"00:01:00",
        "value": "2"
      }
    ]
  end
end
