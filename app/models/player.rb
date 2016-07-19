class Player < ApplicationRecord
  has_secure_password
  belongs_to :league
  has_many :player_matches
  has_many :matches, through: :player_matches
# has_and_belongs_to_many :matches
  validates :user_name, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :password, presence: true
end
