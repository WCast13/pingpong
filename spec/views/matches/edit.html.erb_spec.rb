require 'rails_helper'

RSpec.describe "matches/edit", type: :view do
  before(:each) do
    @match = assign(:match, Match.create!(
      :winners_slack_name => "MyString",
      :losers_slack_name => "MyString",
      :winners_score => 1,
      :losers_score => 1
    ))
  end

  it "renders the edit match form" do
    render

    assert_select "form[action=?][method=?]", match_path(@match), "post" do

      assert_select "input#match_winners_slack_name[name=?]", "match[winners_slack_name]"

      assert_select "input#match_losers_slack_name[name=?]", "match[losers_slack_name]"

      assert_select "input#match_winners_score[name=?]", "match[winners_score]"

      assert_select "input#match_losers_score[name=?]", "match[losers_score]"
    end
  end
end
