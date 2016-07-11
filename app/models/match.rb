class Match < ApplicationRecord
has_many :player_matches
has_many :players, through: :player_matches
# has_and_belongs_to_many :players
players = Player.all
players.each do |player|
if player.slack_name.include?(":winners_slack_name")
validates :winners_slack_name, presence: true
validates :winners_slack_name, presence: true
validates :winners_score, presence:true
validates :losers_score, presence: true
end
end

end
