require 'rails_helper'

RSpec.describe "matches/new", type: :view do
  before(:each) do
    assign(:match, Match.new(
      :winners_slack_name => "MyString",
      :losers_slack_name => "MyString",
      :winners_score => 1,
      :losers_score => 1
    ))
  end

  it "renders new match form" do
    render

    assert_select "form[action=?][method=?]", matches_path, "post" do

      assert_select "input#match_winners_slack_name[name=?]", "match[winners_slack_name]"

      assert_select "input#match_losers_slack_name[name=?]", "match[losers_slack_name]"

      assert_select "input#match_winners_score[name=?]", "match[winners_score]"

      assert_select "input#match_losers_score[name=?]", "match[losers_score]"
    end
  end
end
