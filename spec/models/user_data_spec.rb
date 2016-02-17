require "spec_helper"

RSpec.describe UserData, type: :model do
  it "has valid attributes" do
    friends = build_list(:friend, 2)
    sleep = build_list(:sleep, 2)
    heartrate = build_list(:heartrate, 2)
    last_nights_sleep = build(:last_nights_sleep)

    user_data = UserData.new(friends:           friends,
                             sleep:             sleep,
                             heartrate:         heartrate,
                             last_nights_sleep: last_nights_sleep)

    expect(user_data.friends).to eq(friends)
    expect(user_data.sleep).to eq(sleep)
    expect(user_data.heartrate).to eq(heartrate)
    expect(user_data.last_nights_sleep).to eq(last_nights_sleep)
  end

  it "#all_heartrates returns array of heartrates" do
    friends = build_list(:friend, 2)
    sleep = build_list(:sleep, 2)
    heartrates = [build(:heartrate, rate: 84), build(:heartrate, rate: 88)]
    last_nights_sleep = build(:last_nights_sleep)

    user_data = UserData.new(friends:           friends,
                             sleep:             sleep,
                             heartrate:         heartrates,
                             last_nights_sleep: last_nights_sleep)

    expect(user_data.all_heartrates).to eq([84, 88])
  end

  it "#heartrate_points returns array of heartrate date and rate hashes" do
    friends = build_list(:friend, 2)
    sleep = build_list(:sleep, 2)
    heartrates = [build(:heartrate, rate: 84, date: "2016-02-16"),
                  build(:heartrate, rate: 88, date: "2016-02-17")]
    last_nights_sleep = build(:last_nights_sleep)

    user_data = UserData.new(friends:           friends,
                             sleep:             sleep,
                             heartrate:         heartrates,
                             last_nights_sleep: last_nights_sleep)

    points = [
      { name: "2016-02-16", y: 84 },
      { name: "2016-02-17", y: 88 }
    ]

    expect(user_data.heartrate_points).to eq(points)
  end

  it "#minimum_heartrate returns minimum rate" do
    friends = build_list(:friend, 2)
    sleep = build_list(:sleep, 2)
    heartrates = [build(:heartrate, rate: 84), build(:heartrate, rate: 88)]
    last_nights_sleep = build(:last_nights_sleep)

    user_data = UserData.new(friends:           friends,
                             sleep:             sleep,
                             heartrate:         heartrates,
                             last_nights_sleep: last_nights_sleep)

    expect(user_data.minimum_heartrate).to eq(84)
  end

  it "#todays_heartrate returns last heartrate" do
    friends = build_list(:friend, 2)
    sleep = build_list(:sleep, 2)
    heartrates = [build(:heartrate, rate: 84), build(:heartrate, rate: 88)]
    last_nights_sleep = build(:last_nights_sleep)

    user_data = UserData.new(friends:           friends,
                             sleep:             sleep,
                             heartrate:         heartrates,
                             last_nights_sleep: last_nights_sleep)

    expect(user_data.todays_heartrate).to eq(88)
  end
end
