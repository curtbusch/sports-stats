class Player < ApplicationRecord
  belongs_to :team

  validates :name, :teamId, presence: true
  validates :jersey_number, numericality: { less_than_or_equal_to: 99 }
  validates :teamId, numericality: { only_integer: true }
end
