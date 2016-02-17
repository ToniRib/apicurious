require "spec_helper"

RSpec.describe Friend, type: :model do
  it "has valid attributes" do
    friend = Friend.new(rank: 1,
                        total_steps: 45000,
                        name: "Selby",
                        avatar: img)

    expect(friend.rank).to eq(1)
    expect(friend.total_steps).to eq(45000)
    expect(friend.name).to eq("Selby")
    expect(friend.avatar).to eq(img)
  end

  it "#active? returns true if user has more than 0 total steps" do
    friend = Friend.new(rank: 1,
                        total_steps: 45000,
                        name: "Selby",
                        avatar: img)

    expect(friend.active?).to be true
  end

  it "#active? returns false if user has 0 total steps" do
    friend = Friend.new(rank: 10,
                        total_steps: 0,
                        name: "Selby",
                        avatar: img)

    expect(friend.active?).to be false
  end

  def img
    "https://d6y8zfzc2qfsl.cloudfront.net/99B584FA" \
    "-F8CE-A17E-A909-E845D110973B_profile_64_square.jpg"
  end
end
