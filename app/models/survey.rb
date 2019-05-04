class Survey < ApplicationRecord
  has_many :options, dependent: :destroy

  #validates :options, length: { minimum: 3 }
  validates_presence_of :title, :startDate, :endDate, :status
end
