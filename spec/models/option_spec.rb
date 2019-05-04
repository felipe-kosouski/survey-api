require 'rails_helper'

RSpec.describe Option, type: :model do
  it { should belong_to(:survey) }
  it { should validate_presence_of(:title) }
end
