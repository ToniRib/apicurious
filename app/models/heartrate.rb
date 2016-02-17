class Heartrate
  attr_reader :date, :rate

  def initialize(date:, rate:)
    @date = date
    @rate = rate
  end
end
