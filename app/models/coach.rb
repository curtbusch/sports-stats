class Coach < ApplicationRecord
  belongs_to :team, optional: true

  validates :name, :teamId, presence: true
  validates :teamId, numericality: { only_integer: true }
end
