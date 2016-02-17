class LastNightsSleep
  attr_reader :restless_count, :awake_count, :minutes_asleep,
              :start_time, :date, :time_in_bed, :minute_data

  def initialize(restless_count:, awake_count:, minutes_asleep:,
                 start_time:, date:, time_in_bed:, minute_data:)
    @restless_count = restless_count
    @awake_count = awake_count
    @minutes_asleep = minutes_asleep
    @start_time = start_time
    @date = date
    @time_in_bed = time_in_bed
    @minute_data = minute_data
  end

  def asleep_time_in_hours
    hours = minutes_asleep / 60
    minutes = minutes_asleep - (hours * 60)
    "#{hours} hrs #{minutes} mins"
  end

  def chart
    LazyHighCharts::HighChart.new("pie") do |f|
      f.chart(type: "pie")
      f.legend(enabled: false)
      f.series(innerSize: "50%", data: sleep_points)
      f.plotOptions( pie: { startAngle: -90,
                            endAngle: 90,
                            center: ["50%", "75%"],
                            dataLabels: { enabled: false } })
    end
  end

  private

  def value_name(value)
    case value
    when "1" then "asleep"
    when "2" then "restless"
    when "3" then "awake"
    end
  end

  def value_color(value)
    case value
    when "1" then asleep_color
    when "2" then restless_color
    when "3" then awake_color
    end
  end

  def sleep_points
    minute_data.map do |point|
      {
        y: point["value"].to_i,
        name: value_name(point["value"]),
        color:value_color(point["value"])
      }
    end
  end

  def asleep_color
    "#01558a"
  end

  def restless_color
    "#00bdb7"
  end

  def awake_color
    "#f93dbe"
  end
end
