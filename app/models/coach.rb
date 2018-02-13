class Coach < ApplicationRecord
  belongs_to :team

  validates :name, :teamId, presence: true
  validates :teamId, numericality: { only_integer: true }
end
