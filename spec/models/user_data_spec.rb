require "spec_helper"

RSpec.describe UserData, type: :model do
  it "has valid attributes" do
    friends = build_list(:friend, 2)
    sleep = build_list(:sleep, 2)
    heartrate = build_list(:heartrate, 2)
    last_nights_sleep = build(:last_nights_sleep)
    badge = build(:badge)
    daily_goals = build(:daily_goals)
    weekly_goals = build(:weekly_goals)
    daily_activity = build(:daily_activity)

    user_data = UserData.new(friends:           friends,
                             sleep:             sleep,
                             heartrate:         heartrate,
                             last_nights_sleep: last_nights_sleep,
                             badges:            badge,
                             daily_goals:       daily_goals,
                             weekly_goals:      weekly_goals,
                             daily_activity:    daily_activity)

    expect(user_data.friends).to eq(friends)
    expect(user_data.sleep).to eq(sleep)
    expect(user_data.heartrate).to eq(heartrate)
    expect(user_data.last_nights_sleep).to eq(last_nights_sleep)
    expect(user_data.badges).to eq(badge)
    expect(user_data.daily_goals).to eq(daily_goals)
    expect(user_data.weekly_goals).to eq(weekly_goals)
    expect(user_data.daily_activity).to eq(daily_activity)
  end

  it "#all_heartrates returns array of heartrates" do
    friends = build_list(:friend, 2)
    sleep = build_list(:sleep, 2)
    heartrates = [build(:heartrate, rate: 84), build(:heartrate, rate: 88)]
    last_nights_sleep = build(:last_nights_sleep)
    badge = build(:badge)
    daily_goals = build(:daily_goals)
    weekly_goals = build(:weekly_goals)
    daily_activity = build(:daily_activity)

    user_data = UserData.new(friends:           friends,
                             sleep:             sleep,
                             heartrate:         heartrates,
                             last_nights_sleep: last_nights_sleep,
                             badges:            badge,
                             daily_goals:       daily_goals,
                             weekly_goals:      weekly_goals,
                             daily_activity:    daily_activity)

    expect(user_data.all_heartrates).to eq([84, 88])
  end

  it "#all_heartrates returns array of single heartrate if only one data point" do
    friends = build_list(:friend, 2)
    sleep = build_list(:sleep, 2)
    heartrate = build(:heartrate, rate: 84)
    last_nights_sleep = build(:last_nights_sleep)
    badge = build(:badge)
    daily_goals = build(:daily_goals)
    weekly_goals = build(:weekly_goals)
    daily_activity = build(:daily_activity)

    user_data = UserData.new(friends:           friends,
                             sleep:             sleep,
                             heartrate:         heartrate,
                             last_nights_sleep: last_nights_sleep,
                             badges:            badge,
                             daily_goals:       daily_goals,
                             weekly_goals:      weekly_goals,
                             daily_activity:    daily_activity)

    expect(user_data.all_heartrates).to eq([84])
  end

  it "#heartrate_points returns array of heartrate date and rate hashes" do
    friends = build_list(:friend, 2)
    sleep = build_list(:sleep, 2)
    heartrates = [build(:heartrate, rate: 84, date: "2016-02-16"),
                  build(:heartrate, rate: 88, date: "2016-02-17")]
    last_nights_sleep = build(:last_nights_sleep)
    badge = build(:badge)
    daily_goals = build(:daily_goals)
    weekly_goals = build(:weekly_goals)
    daily_activity = build(:daily_activity)

    user_data = UserData.new(friends:           friends,
                             sleep:             sleep,
                             heartrate:         heartrates,
                             last_nights_sleep: last_nights_sleep,
                             badges:            badge,
                             daily_goals:       daily_goals,
                             weekly_goals:      weekly_goals,
                             daily_activity:    daily_activity)

    points = [
      { name: "2016-02-16", y: 84 },
      { name: "2016-02-17", y: 88 }
    ]

    expect(user_data.heartrate_points).to eq(points)
  end

  it "#heartrate_points returns single point in array if only one heartrate" do
    friends = build_list(:friend, 2)
    sleep = build_list(:sleep, 2)
    heartrate = build(:heartrate)
    last_nights_sleep = build(:last_nights_sleep)
    badge = build(:badge)
    daily_goals = build(:daily_goals)
    weekly_goals = build(:weekly_goals)
    daily_activity = build(:daily_activity)

    user_data = UserData.new(friends:           friends,
                             sleep:             sleep,
                             heartrate:         heartrate,
                             last_nights_sleep: last_nights_sleep,
                             badges:            badge,
                             daily_goals:       daily_goals,
                             weekly_goals:      weekly_goals,
                             daily_activity:    daily_activity)

    point = [{ name: "2016-02-16", y: 84 }]

    expect(user_data.heartrate_points).to eq(point)
  end

  it "#minimum_heartrate returns minimum rate" do
    friends = build_list(:friend, 2)
    sleep = build_list(:sleep, 2)
    heartrates = [build(:heartrate, rate: 84), build(:heartrate, rate: 88)]
    last_nights_sleep = build(:last_nights_sleep)
    badge = build(:badge)
    daily_goals = build(:daily_goals)
    weekly_goals = build(:weekly_goals)
    daily_activity = build(:daily_activity)

    user_data = UserData.new(friends:           friends,
                             sleep:             sleep,
                             heartrate:         heartrates,
                             last_nights_sleep: last_nights_sleep,
                             badges:            badge,
                             daily_goals:       daily_goals,
                             weekly_goals:      weekly_goals,
                             daily_activity:    daily_activity)

    expect(user_data.minimum_heartrate).to eq(84)
  end

  it "#todays_heartrate returns last heartrate" do
    friends = build_list(:friend, 2)
    sleep = build_list(:sleep, 2)
    heartrates = [build(:heartrate, rate: 84), build(:heartrate, rate: 88)]
    last_nights_sleep = build(:last_nights_sleep)
    badge = build(:badge)
    daily_goals = build(:daily_goals)
    weekly_goals = build(:weekly_goals)
    daily_activity = build(:daily_activity)

    user_data = UserData.new(friends:           friends,
                             sleep:             sleep,
                             heartrate:         heartrates,
                             last_nights_sleep: last_nights_sleep,
                             badges:            badge,
                             daily_goals:       daily_goals,
                             weekly_goals:      weekly_goals,
                             daily_activity:    daily_activity)

    expect(user_data.todays_heartrate).to eq(88)
  end

  it "#latest_badges returns list of latest badges" do
    friends = build_list(:friend, 2)
    sleep = build_list(:sleep, 2)
    heartrate = build_list(:heartrate, 2)
    last_nights_sleep = build(:last_nights_sleep)
    badges = [build(:badge, type: "DAILY_STEPS", value: 25000),
              build(:badge, type: "DAILY_STEPS", value: 30000)]
    daily_goals = build(:daily_goals)
    weekly_goals = build(:weekly_goals)
    daily_activity = build(:daily_activity)

    user_data = UserData.new(friends:           friends,
                             sleep:             sleep,
                             heartrate:         heartrate,
                             last_nights_sleep: last_nights_sleep,
                             badges:            badges,
                             daily_goals:       daily_goals,
                             weekly_goals:      weekly_goals,
                             daily_activity:    daily_activity)

    expect(user_data.latest_badges).to eq([badges.last])
    expect(user_data.latest_badges.first.value).to eq(30000)
  end

  it "#weekly_step_goal_progress returns percentage of goal complete" do
    friends = build_list(:friend, 2)
    sleep = build_list(:sleep, 2)
    heartrate = build_list(:heartrate, 2)
    last_nights_sleep = build(:last_nights_sleep)
    badge = build(:badge)
    daily_goals = build(:daily_goals)
    weekly_goals = build(:weekly_goals)
    daily_activity = [build(:daily_activity, steps: 7500),
                      build(:daily_activity, steps: 8000, date: "02-17-2016")]

    user_data = UserData.new(friends:           friends,
                             sleep:             sleep,
                             heartrate:         heartrate,
                             last_nights_sleep: last_nights_sleep,
                             badges:            badge,
                             daily_goals:       daily_goals,
                             weekly_goals:      weekly_goals,
                             daily_activity:    daily_activity)

    expect(user_data.weekly_step_goal_progress).to eq("22%")
  end

  it "#weekly_calorie_goal_progress returns percentage of goal complete" do
    friends = build_list(:friend, 2)
    sleep = build_list(:sleep, 2)
    heartrate = build_list(:heartrate, 2)
    last_nights_sleep = build(:last_nights_sleep)
    badge = build(:badge)
    daily_goals = build(:daily_goals)
    weekly_goals = build(:weekly_goals)
    daily_activity = [build(:daily_activity, calories: 2300),
                      build(:daily_activity, calories: 2500, date: "02-17-2016")]

    user_data = UserData.new(friends:           friends,
                             sleep:             sleep,
                             heartrate:         heartrate,
                             last_nights_sleep: last_nights_sleep,
                             badges:            badge,
                             daily_goals:       daily_goals,
                             weekly_goals:      weekly_goals,
                             daily_activity:    daily_activity)

    expect(user_data.weekly_calorie_goal_progress).to eq("26%")
  end

  it "#weekly_floor_goal_progress returns percentage of goal complete" do
    friends = build_list(:friend, 2)
    sleep = build_list(:sleep, 2)
    heartrate = build_list(:heartrate, 2)
    last_nights_sleep = build(:last_nights_sleep)
    badge = build(:badge)
    daily_goals = build(:daily_goals)
    weekly_goals = build(:weekly_goals)
    daily_activity = [build(:daily_activity, floors: 11),
                      build(:daily_activity, floors: 20, date: "02-17-2016")]

    user_data = UserData.new(friends:           friends,
                             sleep:             sleep,
                             heartrate:         heartrate,
                             last_nights_sleep: last_nights_sleep,
                             badges:            badge,
                             daily_goals:       daily_goals,
                             weekly_goals:      weekly_goals,
                             daily_activity:    daily_activity)

    expect(user_data.weekly_floor_goal_progress).to eq("25%")
  end

  it "#calculate_progress returns 100 if over 100% complete" do
    friends = build_list(:friend, 2)
    sleep = build_list(:sleep, 2)
    heartrate = build_list(:heartrate, 2)
    last_nights_sleep = build(:last_nights_sleep)
    badge = build(:badge)
    daily_goals = build(:daily_goals)
    weekly_goals = build(:weekly_goals)
    daily_activity = [build(:daily_activity, floors: 1000),
                      build(:daily_activity, floors: 20, date: "02-17-2016")]

    user_data = UserData.new(friends:           friends,
                             sleep:             sleep,
                             heartrate:         heartrate,
                             last_nights_sleep: last_nights_sleep,
                             badges:            badge,
                             daily_goals:       daily_goals,
                             weekly_goals:      weekly_goals,
                             daily_activity:    daily_activity)

    expect(user_data.weekly_floor_goal_progress).to eq("100%")
  end
end
