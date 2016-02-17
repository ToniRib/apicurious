class UserData
  attr_reader :friends, :sleep, :heartrate

  def load(friends:, sleep:, heartrate:)
    @friends = friends
    @sleep = sleep
    @heartrate = heartrate
  end

  def all_heartrates
    heartrate.map { |h| h.rate }
  end

  def minimum_heartrate
    all_heartrates.min
  end
end
