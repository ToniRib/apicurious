class Friend
  attr_reader :rank, :total_steps, :name, :avatar

  def initialize(rank:, total_steps:, name:, avatar:)
    @rank = rank
    @total_steps = total_steps
    @name = name
    @avatar = avatar
  end

  def active?
    total_steps > 0
  end
end
