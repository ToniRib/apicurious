class FitbitService
  attr_reader :user

  def initialize(user)
    @user = user
    @connection = Faraday.new(:url => "https://api.fitbit.com/1/user/#{user.uid}/") do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def get_user_data
    asleep, awake, awakenings = get_sleep

    UserData.new(friends:   create_friends(get("friends/leaderboard.json")),
                 sleep:     create_sleep(asleep, awake, awakenings),
                 heartrate: create_heartrate(get("activities/heart/date/#{Date.today.to_s}/30d.json")),
                 last_nights_sleep: create_last_nights_sleep(get("sleep/date/#{Date.today.to_s}.json")),
                 badges:    create_badges(get("badges.json"))
    )
  end

  def get(path)
    response = @connection.get do |request|
      request.url(path)
      request.headers["Authorization"] = "Bearer #{user.token}"
    end

    JSON.parse(response.body)
  end

  private

  def get_sleep
    minutes_asleep = get("sleep/minutesAsleep/date/#{Date.today.to_s}/7d.json")
    minutes_awake = get("sleep/minutesAwake/date/#{Date.today.to_s}/7d.json")
    awakenings_count = get("sleep/awakeningsCount/date/#{Date.today.to_s}/7d.json")

    [minutes_asleep["sleep-minutesAsleep"],
     minutes_awake["sleep-minutesAwake"],
     awakenings_count["sleep-awakeningsCount"]]
  end


  def create_friends(response)
    response["friends"].map { |info| Friend.new(rank: info["rank"]["steps"],
                                                total_steps: info["summary"]["steps"],
                                                name: info["user"]["displayName"],
                                                avatar: info["user"]["avatar"]) }
  end

  def create_sleep(asleep, awake, awakenings)
    asleep.map.with_index do |entry, index|
      Sleep.new(time_asleep: entry["value"],
                time_awake:  awake[index]["value"],
                awakenings:  awakenings[index]["value"],
                date:        entry["dateTime"])
    end
  end

  def create_heartrate(response)
    heart_rates = response["activities-heart"].select do |entry|
      entry["value"]["restingHeartRate"]
    end

    heart_rates.map do |entry|
      Heartrate.new(date: entry["dateTime"],
                    rate: entry["value"]["restingHeartRate"])
    end
  end

  def create_last_nights_sleep(response)
    response = response["sleep"].first
    LastNightsSleep.new(restless_count: response["restlessCount"],
                        awake_count:    response["awakeCount"],
                        minutes_asleep: response["minutesAsleep"],
                        start_time:     response["startTime"],
                        date:           response["dateOfSleep"],
                        time_in_bed:    response["timeInBed"],
                        minute_data:    response["minuteData"]
    )
  end

  def create_badges(response)
    response["badges"].map do |badge|
      Badge.new(type:        badge["badgeType"],
                date:        badge["dateTime"],
                description: badge["description"],
                image:       badge["image125px"],
                value:       badge["value"])
    end
  end
end
