require "rails_helper"

RSpec.describe User, type: :model do
  it { should validate_uniqueness_of(:uid).scoped_to(:provider) }
  it { should validate_presence_of(:token) }
end
