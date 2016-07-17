class Match < ApplicationRecord
has_many :player_matches
has_many :players, through: :player_matches
# has_and_belongs_to_many :players
array = []
Player.all.each do |player|
  array << player.user_name
end
validates_inclusion_of :opponent_username, in: array, message: "The username is not in this league, Sorry :("
end





#for every match the player has been in, if the player won add 1 to wins
#if the player losses, added one to losses
#if he won add the winners score pf, and the losing score to pa
#if he lost, add the losing score to pf, and the winning score to pa
#have these changes reflect on standings
