FactoryGirl.define do
  factory :friend do
    skip_create

    rank 1
    total_steps 45000
    name "Selby"
    avatar "https://d6y8zfzc2qfsl.cloudfront.net/99B584FA" \
           "-F8CE-A17E-A909-E845D110973B_profile_64_square.jpg"

    initialize_with { new(attributes) }
  end

  factory :sleep do
    skip_create

    time_asleep "320"
    time_awake "150"
    awakenings "17"
    date "2016-02-16"

    initialize_with { new(attributes) }
  end

  factory :last_nights_sleep do
    skip_create

    restless_count 17
    awake_count 3
    minutes_asleep 206
    start_time "2016-02-16T23:21:00.000"
    date "2016-02-16"
    time_in_bed 520
    minute_data [{
                   "dateTime":"00:00:00",
                   "value": "3"
                 },
                 {
                   "dateTime":"00:01:00",
                   "value": "2"
                 }]

    initialize_with { new(attributes) }
  end

  factory :heartrate do
    skip_create

    date "2016-02-16"
    rate 84

    initialize_with { new(attributes) }
  end

  factory :badge do
    skip_create

    type "DAILY_STEPS"
    date "2016-02-16"
    image "http://static0.fitbit.com/images/badges_new/" \
          "125px/badge_daily_steps30k.png"
    value 30000
    description "30000 steps in a day"

    initialize_with { new(attributes) }
  end

  factory :daily_goals do
    skip_create

    steps "10000"
    calories "2600"
    floors "18"

    initialize_with { new(attributes) }
  end

  factory :weekly_goals do
    skip_create

    steps "70000"
    calories "18200"
    floors "126"

    initialize_with { new(attributes) }
  end

  factory :daily_activity do
    skip_create

    date "02-16-2016"
    steps 7500
    floors 11
    calories 2300

    initialize_with { new(attributes) }
  end
end
