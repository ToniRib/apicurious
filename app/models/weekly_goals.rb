class WeeklyGoals
  attr_reader :steps, :floors, :calories

  def initialize(steps:, floors:, calories:)
    @steps = steps.to_i
    @floors = floors.to_i
    @calories = calories.to_i
  end

  def set_calorie_goal(num)
    @calories = num
  end
end
