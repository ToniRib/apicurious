class Sleep
  attr_reader :time_asleep, :time_awake, :awakenings, :date

  def initialize(time_asleep:, time_awake:, awakenings:, date:)
    @time_asleep = time_asleep.to_i
    @time_awake  = time_awake.to_i
    @awakenings  = awakenings.to_i
    @date        = Date.parse(date)
  end

  def logged?
    time_asleep > 0
  end

  def time_asleep_in_hours
    in_hours(time_asleep)
  end

  def time_awake_in_hours
    in_hours(time_awake)
  end

  private

  def in_hours(time)
    hours = time / 60
    minutes = time - (hours * 60)
    "#{hours} hours #{minutes} minutes"
  end
end
