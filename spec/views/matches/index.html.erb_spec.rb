require 'rails_helper'

RSpec.describe "matches/index", type: :view do
  before(:each) do
    assign(:matches, [
      Match.create!(
        :winners_slack_name => "Winners Slack Name",
        :losers_slack_name => "Losers Slack Name",
        :winners_score => 2,
        :losers_score => 3
      ),
      Match.create!(
        :winners_slack_name => "Winners Slack Name",
        :losers_slack_name => "Losers Slack Name",
        :winners_score => 2,
        :losers_score => 3
      )
    ])
  end

  it "renders a list of matches" do
    render
    assert_select "tr>td", :text => "Winners Slack Name".to_s, :count => 2
    assert_select "tr>td", :text => "Losers Slack Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
