class League < ApplicationRecord
  has_many :teams

  validates :name, :fullname, presence: true
  validates :name, format: { with: /\^[A-Z]+\$/ }
end
