class FitbitService
  def initialize
    @connection = Faraday.new(:url => "https://api.fitbit.com/1/user/-/") do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def get_friends(user)
    response = @connection.get do |request|
      request.url("friends/leaderboard.json")
      request.headers["Authorization"] = "Bearer #{user.token}"
    end
    response = JSON.parse(response.body)
    create_friends(response)
  end

  private

  def create_friends(response)
    response["friends"].map { |info| Friend.new(rank: info["rank"]["steps"],
                                                total_steps: info["summary"]["steps"],
                                                name: info["user"]["displayName"],
                                                avatar: info["user"]["avatar"]) }
  end
end
