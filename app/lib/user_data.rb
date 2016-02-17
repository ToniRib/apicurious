class UserData
  attr_reader :friends, :sleep, :heartrate

  def load(friends:, sleep:, heartrate:)
    @friends = friends
    @sleep = sleep
    @heartrate = heartrate
  end
end
