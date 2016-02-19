class Badge
  attr_reader :type, :date, :image, :value, :description

  def initialize(type:, date:, image:, value:, description:)
    @type        = type
    @date        = date
    @image       = image
    @value       = value
    @description = description
  end
end
