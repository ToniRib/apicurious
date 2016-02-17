class FitbitService
  attr_reader :user

  def initialize(user)
    @user = user
    @connection = Faraday.new(:url => "https://api.fitbit.com/1/user/-/") do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def get_user_data
    user_data = UserData.new
    asleep, awake, awakenings = get_sleep
    user_data.load(friends:   create_friends(get("friends/leaderboard.json")),
                   sleep:     create_sleep(asleep, awake, awakenings),
                   heartrate: resting_heartrate_only(get("activities/heart/date/#{Date.today.to_s}/30d.json"))
    )
    user_data
  end

  def get(path)
    response = @connection.get do |request|
      request.url(path)
      request.headers["Authorization"] = "Bearer #{user.token}"
    end

    JSON.parse(response.body)
  end

  # def get_friends
  #   response = @connection.get do |request|
  #     request.url("friends/leaderboard.json")
  #     request.headers["Authorization"] = "Bearer #{user.token}"
  #   end
  #   response = JSON.parse(response.body)
  #   create_friends(response)
  # end

  def get_sleep
    minutes_asleep = get("sleep/minutesAsleep/date/#{Date.today.to_s}/7d.json")
    minutes_awake = get("sleep/minutesAwake/date/#{Date.today.to_s}/7d.json")
    awakenings_count = get("sleep/awakeningsCount/date/#{Date.today.to_s}/7d.json")

    [minutes_asleep["sleep-minutesAsleep"],
     minutes_awake["sleep-minutesAwake"],
     awakenings_count["sleep-awakeningsCount"]]
  end
  #
  # def get_resting_heartrate
  #   response = @connection.get do |request|
  #     request.url("activities/heart/date/#{Date.today.to_s}/30d.json")
  #     request.headers["Authorization"] = "Bearer #{user.token}"
  #   end
  #   response = JSON.parse(response.body)
  #   resting_heartrate_only(response)
  # end

  private

  def create_friends(response)
    response["friends"].map { |info| Friend.new(rank: info["rank"]["steps"],
                                                total_steps: info["summary"]["steps"],
                                                name: info["user"]["displayName"],
                                                avatar: info["user"]["avatar"]) }
  end
  #
  # def get_minutes_asleep
  #   response = @connection.get do |request|
  #     request.url("sleep/minutesAsleep/date/#{Date.today.to_s}/7d.json")
  #     request.headers["Authorization"] = "Bearer #{user.token}"
  #   end
  #   JSON.parse(response.body)
  # end
  #
  # def get_minutes_awake
  #   response = @connection.get do |request|
  #     request.url("sleep/minutesAwake/date/#{Date.today.to_s}/7d.json")
  #     request.headers["Authorization"] = "Bearer #{user.token}"
  #   end
  #   JSON.parse(response.body)
  # end
  #
  # def get_awakenings_count
  #   response = @connection.get do |request|
  #     request.url("sleep/awakeningsCount/date/#{Date.today.to_s}/7d.json")
  #     request.headers["Authorization"] = "Bearer #{user.token}"
  #   end
  #   JSON.parse(response.body)
  # end

  def create_sleep(asleep, awake, awakenings)
    asleep.map.with_index do |entry, index|
      Sleep.new(time_asleep: entry["value"],
                time_awake:  awake[index]["value"],
                awakenings:  awakenings[index]["value"],
                date:        entry["dateTime"])
    end
  end

  def resting_heartrate_only(response)
    heart_rates = response["activities-heart"].select do |entry|
      entry["value"]["restingHeartRate"]
    end

    heart_rates.map do |entry|
      { date: entry["dateTime"], heart_rate: entry["value"]["restingHeartRate"] }
    end
  end
end
