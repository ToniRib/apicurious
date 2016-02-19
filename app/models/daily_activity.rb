class DailyActivity
  attr_reader :date, :steps, :floors, :calories

  def initialize(date:, steps:, floors:, calories:)
    @date = date
    @steps = steps
    @floors = floors
    @calories = calories
  end
end
