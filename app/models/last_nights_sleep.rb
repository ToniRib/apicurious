class LastNightsSleep
  attr_reader :restless_count, :awake_count, :minutes_asleep,
              :start_time, :date, :time_in_bed, :minute_data

  def initialize(restless_count:, awake_count:, minutes_asleep:,
                 start_time:, date:, time_in_bed:, minute_data:)
    @restless_count = restless_count
    @awake_count = awake_count
    @minutes_asleep = minutes_asleep
    @start_time = start_time
    @date = date
    @time_in_bed = time_in_bed
    @minute_data = minute_data
  end

  def asleep_time_in_hours
    hours = minutes_asleep / 60
    minutes = minutes_asleep - (hours * 60)
    "#{hours} hours #{minutes} minutes"
  end
end
