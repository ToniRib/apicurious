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

  def get_friends
    response = @connection.get do |request|
      request.url("friends/leaderboard.json")
      request.headers["Authorization"] = "Bearer #{user.token}"
    end
    response = JSON.parse(response.body)
    create_friends(response)
  end

  def get_sleep
    minutes_asleep = get_minutes_asleep
    minutes_awake = get_minutes_awake
    awakenings_count = get_awakenings_count

    create_sleep(minutes_asleep["sleep-minutesAsleep"],
                 minutes_awake["sleep-minutesAwake"],
                 awakenings_count["sleep-awakeningsCount"])
  end

  private

  def create_friends(response)
    response["friends"].map { |info| Friend.new(rank: info["rank"]["steps"],
                                                total_steps: info["summary"]["steps"],
                                                name: info["user"]["displayName"],
                                                avatar: info["user"]["avatar"]) }
  end

  def get_minutes_asleep
    response = @connection.get do |request|
      request.url("sleep/minutesAsleep/date/#{Date.today.to_s}/30d.json")
      request.headers["Authorization"] = "Bearer #{user.token}"
    end
    JSON.parse(response.body)
  end

  def get_minutes_awake
    response = @connection.get do |request|
      request.url("sleep/minutesAwake/date/#{Date.today.to_s}/30d.json")
      request.headers["Authorization"] = "Bearer #{user.token}"
    end
    JSON.parse(response.body)
  end

  def get_awakenings_count
    response = @connection.get do |request|
      request.url("sleep/awakeningsCount/date/#{Date.today.to_s}/30d.json")
      request.headers["Authorization"] = "Bearer #{user.token}"
    end
    JSON.parse(response.body)
  end

  def create_sleep(asleep, awake, awakenings)
    asleep.map.with_index do |entry, index|
      Sleep.new(time_asleep: entry["value"],
                time_awake:  awake[index]["value"],
                awakenings:  awakenings[index]["value"],
                date:        entry["dateTime"])
    end
  end
end
