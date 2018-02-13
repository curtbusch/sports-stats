class Team < ApplicationRecord
  belongs_to :league
  has_many :players

  validates :team_name, :city, :league_id, presence: true
  validates :league_id, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 3 }
end
