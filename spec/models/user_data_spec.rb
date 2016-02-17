require "spec_helper"

RSpec.describe UserData, type: :model do
  it "has valid attributes" do
    friends, sleep, heartrate, last_nights_sleep, user_data = build_user_data

    expect(user_data.friends).to eq(friends)
    expect(user_data.sleep).to eq(sleep)
    expect(user_data.heartrate).to eq(heartrate)
    expect(user_data.last_nights_sleep).to eq(last_nights_sleep)
  end

  it "#all_heartrates returns array of heartrates" do
    friends, sleep, heartrate, last_nights_sleep, user_data = build_user_data

    expect(user_data.all_heartrates).to eq([84, 84])
  end

  def build_user_data
    friends = build_list(:friend, 2)
    sleep = build_list(:sleep, 2)
    heartrate = build_list(:heartrate, 2)
    last_nights_sleep = build(:last_nights_sleep)

    user_data = UserData.new(friends:           friends,
                             sleep:             sleep,
                             heartrate:         heartrate,
                             last_nights_sleep: last_nights_sleep)

    [friends, sleep, heartrate, last_nights_sleep, user_data]
  end
end
