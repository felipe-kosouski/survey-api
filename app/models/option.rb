class Option < ApplicationRecord
  belongs_to :survey

  validates_presence_of :title
end
