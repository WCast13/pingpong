require 'rails_helper'

RSpec.describe "matches/show", type: :view do
  before(:each) do
    @match = assign(:match, Match.create!(
      :winners_slack_name => "Winners Slack Name",
      :losers_slack_name => "Losers Slack Name",
      :winners_score => 2,
      :losers_score => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Winners Slack Name/)
    expect(rendered).to match(/Losers Slack Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
