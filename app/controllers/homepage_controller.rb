class HomepageController < ApplicationController
  def home
    current_player
      not_a_user
      Player.find(2).update(standings_position: 1)
      Player.find(1).update(standings_position: 2)
      @player_ladder = @current_player.standings_position
      @one_up_ladder = Player.find_by(standings_position: @current_player.standings_position - 1).user_name
      if @current_player.standings_position != 2
      @two_up_ladder = Player.find_by(standings_position: @current_player.standings_position - 2).user_name
    end
  end
end
