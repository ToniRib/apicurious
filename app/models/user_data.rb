class UserData
  attr_reader :friends, :sleep, :heartrate, :last_nights_sleep

  def load(friends:, sleep:, heartrate:, last_nights_sleep:)
    @friends = friends
    @sleep = sleep
    @heartrate = heartrate
    @last_nights_sleep = last_nights_sleep
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

  def todays_sleep
    sleep.last
  end

  def heartrate_chart
    LazyHighCharts::HighChart.new('basic_line') do |f|
      f.chart({ type: 'line',
                marginRight: 130,
                marginBottom: 25 })
      f.yAxis({ title: { text: "Beats per Minute" } })
      f.xAxis(title: { text: "Date" },
              type: "category",
              labels: {enabled: false})
      f.tooltip({ valueSuffix: 'bpm' })
      f.legend(enabled: false)
      f.series({ name: "Resting Heart Rate", data: heartrate_points })
    end
  end
end
