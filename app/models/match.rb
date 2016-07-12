class Match < ApplicationRecord
has_many :player_matches
has_many :players, through: :player_matches
# has_and_belongs_to_many :players
validates :winners_slack_name, presence: true
validates :winners_slack_name, presence: true
validates :winners_score, presence:true
validates :losers_score, presence: true
end





#for every match the player has been in, if the player won add 1 to wins
#if the player losses, added one to losses
#if he won add the winners score pf, and the losing score to pa
#if he lost, add the losing score to pf, and the winning score to pa
#have these changes reflect on standings
