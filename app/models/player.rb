class Player < ApplicationRecord

  validates :slack_name, presence: true
  validates :slack_name, uniqueness: true
  validates :name, presence: true
end
