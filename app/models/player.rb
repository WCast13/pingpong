class Player < ApplicationRecord
has_and_belongs_to_many :matches
  validates :slack_name, presence: true
  validates :slack_name, uniqueness: true
  validates :name, presence: true
end
