FactoryGirl.define do
  factory :friend, aliases: [:friends] do
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
end
