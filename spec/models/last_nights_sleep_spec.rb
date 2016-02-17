require "spec_helper"

RSpec.describe LastNightsSleep, type: :model do
  it "has valid attributes" do
    time = Time.now.to_s
    last = LastNightsSleep.new(restless_count: 17,
                               awake_count:    3,
                               minutes_asleep: 206,
                               start_time:     time,
                               date:           "2016-02-16",
                               time_in_bed:    520,
                               minute_data:    minute_data
    )

    expect(last.restless_count).to eq(17)
    expect(last.awake_count).to eq(3)
    expect(last.minutes_asleep).to eq(206)
    expect(last.start_time).to eq(time)
    expect(last.date).to eq("2016-02-16")
    expect(last.time_in_bed).to eq(520)
    expect(last.minute_data).to eq(minute_data)
  end

  it "#asleep_time_hours returns number of hours asleep" do
    last = LastNightsSleep.new(restless_count: 17,
                               awake_count:    3,
                               minutes_asleep: 206,
                               start_time:     Time.now.to_s,
                               date:           "2016-02-16",
                               time_in_bed:    520,
                               minute_data:    minute_data
    )

    expect(last.asleep_time_hours).to eq(3)
  end

  it "#asleep_time_minutes returns number of minutes minus hours asleep" do
    last = LastNightsSleep.new(restless_count: 17,
                               awake_count:    3,
                               minutes_asleep: 206,
                               start_time:     Time.now.to_s,
                               date:           "2016-02-16",
                               time_in_bed:    520,
                               minute_data:    minute_data
    )

    expect(last.asleep_time_minutes).to eq(26)
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
      },
      {
        "dateTime":"00:02:00",
        "value": "1"
      }
    ]
  end
end
