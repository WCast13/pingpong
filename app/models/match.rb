class Match < ApplicationRecord
has_many :player_matches
has_many :players, through: :player_matches
# has_and_belongs_to_many :players
validates :winners_slack_name, presence: true
validates :winners_score, presence:true
validates :losers_score, presence: true
end
