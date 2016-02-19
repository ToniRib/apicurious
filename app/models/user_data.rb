class UserData
  attr_reader :friends, :sleep, :heartrate, :last_nights_sleep,
              :badges, :daily_activity, :daily_goals, :weekly_goals

  def initialize(friends:, sleep:, heartrate:, last_nights_sleep:,
                 badges:, daily_activity:, daily_goals:, weekly_goals:)
    @friends = friends
    @sleep = sleep
    @heartrate = heartrate
    @last_nights_sleep = last_nights_sleep
    @badges = badges
    @daily_activity = daily_activity
    @daily_goals = daily_goals
    @weekly_goals = weekly_goals
  end

  def all_heartrates
    heartrate.map { |h| h.rate }
  end

  def heartrate_points
    heartrate.map { |h| { name: h.date.to_s, y: h.rate } }
  end

  def minimum_heartrate
    all_heartrates.min
  end

  def todays_heartrate
    all_heartrates.last
  end

  def latest_badges
    grouped = badges.group_by { |b| b.type }
    grouped.map { |name, group| max_of(group) }
  end

  def weekly_step_goal_progress
    progress = (daily_steps.reduce(:+) / weekly_goals.steps.to_f) * 100
    progress = 100 if progress > 100
    "#{progress.round(0)}%"
  end

  def weekly_calorie_goal_progress
    progress = (daily_calories.reduce(:+) / weekly_goals.calories.to_f) * 100
    progress = 100 if progress > 100
    "#{progress.round(0)}%"
  end

  def weekly_floor_goal_progress
    progress = (daily_floors.reduce(:+) / weekly_goals.floors.to_f) * 100
    progress = 100 if progress > 100
    "#{progress.round(0)}%"
  end

  def step_chart
    LazyHighCharts::HighChart.new("column") do |f|
      f.chart(height: 200)
      f.yAxis(title: { text: "Steps" })
      f.xAxis(categories: days_of_the_week)
      f.tooltip(valueSuffix: " steps")
      f.legend(enabled: false)
      f.series(name: "Daily Steps", data: daily_steps, type: "column")
      f.series(name: "Step Goal", data: daily_step_goal, type: "line",
               marker: { enabled: false }, color: "#30ee00")
    end
  end

  def calorie_chart
    LazyHighCharts::HighChart.new("column") do |f|
      f.chart(type: "column", height: 200, width: 728)
      f.yAxis(title: { text: "Calories Burned" })
      f.xAxis(categories: days_of_the_week)
      f.tooltip(valueSuffix: " calories")
      f.legend(enabled: false)
      f.series(name: "Daily Calories Burned", data: daily_calories)
      f.series(name: "Calorie Goal", data: daily_calorie_goal, type: "line",
               marker: { enabled: false }, color: "#30ee00")
    end
  end

  def floor_chart
    LazyHighCharts::HighChart.new("column") do |f|
      f.chart(type: "column", height: 200, width: 728)
      f.yAxis(title: { text: "Floors" })
      f.xAxis(categories: days_of_the_week)
      f.tooltip(valueSuffix: " floors")
      f.legend(enabled: false)
      f.series(name: "Daily Floors Climbed", data: daily_floors)
      f.series(name: "Floor Goal", data: daily_floor_goal, type: "line",
               marker: { enabled: false }, color: "#30ee00")
    end
  end

  def heartrate_chart
    LazyHighCharts::HighChart.new("basic_line") do |f|
      f.chart(type: "line",
              marginBottom: 25,
              height: 200 )
      f.yAxis(title: { text: "Beats per Minute" })
      f.xAxis(title: { text: "Date" },
              type: "category",
              labels: {enabled: false})
      f.tooltip(valueSuffix: "bpm")
      f.legend(enabled: false)
      f.series(name: "Resting Heart Rate", data: heartrate_points)
    end
  end

  private

  def padright!(array, length, number)
    array.fill(number, array.length...length)
  end

  def daily_steps
    steps = daily_activity.map { |da| da.steps }.reverse
    padright!(steps, 7, 0) if steps.length < 7
  end

  def daily_step_goal
    Array.new(7, daily_goals.steps)
  end

  def daily_floors
    floors = daily_activity.map { |da| da.floors }
    padright!(floors, 7, 0) if floors.length < 7
  end

  def daily_floor_goal
    Array.new(7, daily_goals.floors)
  end

  def daily_calories
    calories = daily_activity.map { |da| da.calories }
    padright!(calories, 7, 0) if calories.length < 7
  end

  def daily_calorie_goal
    Array.new(7, daily_goals.calories)
  end

  def days_of_the_week
    Date::DAYNAMES
  end

  def max_of(group)
    if group.size > 1
      group.max { |a, b| a.value <=> b.value }
    else
      group.first
    end
  end
end
