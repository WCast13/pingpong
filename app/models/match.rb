class Match < ApplicationRecord

validates :winners_slack_name, presence: true
validates :winners_score, presence:true
validates :losers_score, presence: true
end
