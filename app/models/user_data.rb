class UserData
  attr_reader :friends, :sleep, :heartrate, :last_nights_sleep, :badges, :daily_activity

  def initialize(friends:, sleep:, heartrate:, last_nights_sleep:, badges:, daily_activity:)
    @friends = friends
    @sleep = sleep
    @heartrate = heartrate
    @last_nights_sleep = last_nights_sleep
    @badges = badges
    @daily_activity = daily_activity
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

  def max_of(group)
    if group.size > 1
      group.max { |a, b| a.value <=> b.value }
    else
      group.first
    end
  end

  def padright!(array, length, number)
    array.fill(number, array.length...length)
  end

  def daily_steps
    steps = daily_activity.map { |da| da.steps }.reverse
    padright!(steps, 7, 0) if steps.length < 7
  end

  def daily_floors
    daily_activity.map { |da| da.floors }
  end

  def daily_calories
    daily_activity.map { |da| da.calories }
  end

  def days_of_the_week
    Date::DAYNAMES
  end

  def step_chart
    LazyHighCharts::HighChart.new("column") do |f|
      f.chart(type: "column", height: 200)
      f.yAxis(title: { text: "Steps" })
      f.xAxis(categories: days_of_the_week)
      f.tooltip(valueSuffix: "steps")
      f.legend(enabled: false)
      f.series(name: "Daily Steps", data: daily_steps)
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
end
