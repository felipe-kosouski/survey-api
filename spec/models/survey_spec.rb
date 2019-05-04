require 'rails_helper'

RSpec.describe Survey, type: :model do
  it { should have_many(:options).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:startDate) }
  it { should validate_presence_of(:endDate) }
  #it { should have_at_least(3).options }
end
