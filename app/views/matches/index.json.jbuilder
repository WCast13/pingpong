json.array!(@matches) do |match|
  json.extract! match, :id, :winners_slack_name, :losers_slack_name, :winners_score, :losers_score
  json.url match_url(match, format: :json)
end
